const { Elm } = require("./Main.elm");
import * as glob from "glob";
import * as childProcess from "child_process";
import * as fs from "fs-extra";
import { GraphQLClient } from "graphql-request";
import * as path from "path";
import {
  removeGenerated,
  warnAndExitIfContainsNonGenerated
} from "./cli/generated-code-handler";
import { applyElmFormat } from "./formatted-write";
import { introspectionQuery } from "./introspection-query";
const npmPackageVersion = require("../../package.json").version;
const elmPackageVersion = require("../../elm.json").version;

const targetComment = `-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql
`;

const versionMessage = `npm version ${npmPackageVersion}\nTargeting elm package dillonkearns/elm-graphql@${elmPackageVersion}`;

function prependBasePath(
  suffixPath: string,
  baseModule: string[],
  outputPath: string
): string {
  return path.join(outputPath, baseModule.join("/"), suffixPath);
}

function loadQueryFiles(
  queryDirectory: string | null
): { [index: string]: string } {
  const queryFiles: { [index: string]: string } = {};
  if (queryDirectory) {
    const filenames = fs.readdirSync(queryDirectory);
    filenames.forEach((filename: string) => {
      queryFiles[filename] = fs.readFileSync(
        queryDirectory + "/" + filename,
        "utf-8"
      );
    });
  }
  return queryFiles;
}

(async () => {
  const elmi = await fs.readFile(
    path.join(
      process.env.HOME || "",
      "src",
      "github.com",
      "dillonkearns",
      "elm-graphql",
      "examples",
      "elm-stuff",
      "0.19.0",
      "ExposesSelection.elmi"
    )
  );

  const elmiFiles: string[] = glob.sync(
    `${process.cwd()}/elm-stuff/0.19.0/*.elmi`
  );

  let app = Elm.Main.init({
    flags: {
      argv: process.argv,
      versionMessage,
      elmi: elmi.toString("base64"),
      elmiFiles: elmiFiles.map(elmiFile => {
        return {
          fileName: path.parse(elmiFile).name,
          fileContents: fs.readFileSync(elmiFile).toString("base64")
        };
      })
    }
  });
  // app.ports.print.subscribe(console.log);
  app.ports.printAndExitFailure.subscribe((message: string) => {
    console.log(message);
    process.exit(1);
  });
  app.ports.printAndExitSuccess.subscribe((message: string) => {
    console.log(message);
    process.exit(0);
  });

  app.ports.introspectSchemaFromFile.subscribe(
    ({
      introspectionFilePath,
      outputPath,
      baseModule,
      queryDirectory,
      customDecodersModule
    }: {
      introspectionFilePath: string;
      outputPath: string;
      baseModule: string[];
      queryDirectory: string | null;
      customDecodersModule: string | null;
    }) => {
      warnAndExitIfContainsNonGenerated({ baseModule, outputPath });
      const introspectionFileJson = JSON.parse(
        fs.readFileSync(introspectionFilePath).toString()
      );

      const queryFiles = loadQueryFiles(queryDirectory);

      onDataAvailable(
        introspectionFileJson.data || introspectionFileJson,
        queryFiles,
        outputPath,
        baseModule,
        customDecodersModule
      );
    }
  );

  app.ports.introspectSchemaFromUrl.subscribe(
    ({
      graphqlUrl,
      excludeDeprecated,
      outputPath,
      queryDirectory,
      baseModule,
      headers,
      customDecodersModule
    }: {
      graphqlUrl: string;
      excludeDeprecated: boolean;
      outputPath: string;
      queryDirectory: string | null;
      baseModule: string[];
      headers: {};
      customDecodersModule: string | null;
    }) => {
      warnAndExitIfContainsNonGenerated({ baseModule, outputPath });

      console.log("Fetching GraphQL schema...");
      new GraphQLClient(graphqlUrl, {
        mode: "cors",
        headers: headers
      })
        .request(introspectionQuery, { includeDeprecated: !excludeDeprecated })
        .then(data => {
          const queryFiles = loadQueryFiles(queryDirectory);
          onDataAvailable(
            data,
            queryFiles,
            outputPath,
            baseModule,
            customDecodersModule
          );
        })
        .catch(err => {
          console.log(err.response || err);
          process.exit(1);
        });
    }
  );

  function makeEmptyDirectories(
    baseModule: string[],
    outputPath: string,
    directoryNames: string[]
  ): void {
    directoryNames.forEach(dir => {
      fs.mkdirpSync(prependBasePath(dir, baseModule, outputPath));
    });
  }

  function onDataAvailable(
    data: {},
    queryFiles: { [index: string]: string },
    outputPath: string,
    baseModule: string[],
    customDecodersModule: string | null
  ) {
    console.log("Generating files...");
    app.ports.generatedFiles.subscribe(async function(generatedFile: {
      [s: string]: string;
    }) {
      removeGenerated(prependBasePath("/", baseModule, outputPath));
      makeEmptyDirectories(baseModule, outputPath, [
        "InputObject",
        "Object",
        "Interface",
        "Union",
        "Enum",
        "Queries"
      ]);
      await Promise.all(writeGeneratedFiles(outputPath, generatedFile)).catch(
        err => {
          console.error("Error writing files", err);
        }
      );
      writeIntrospectionFile(baseModule, outputPath);
      applyElmFormat(prependBasePath("/", baseModule, outputPath));
      if (customDecodersModule) {
        verifyCustomCodecsFileIsValid(
          outputPath,
          baseModule,
          customDecodersModule
        );
      }
      console.log("Success!");
    });
    app.ports.generateFiles.send({ queryFiles, introspectionData: data });
  }
})();

function verifyCustomCodecsFileIsValid(
  outputPath: string,
  baseModule: string[],
  customDecodersModule: string
) {
  const verifyDecodersFile = path.join(
    outputPath,
    ...baseModule,
    "VerifyScalarCodecs.elm"
  );

  try {
    childProcess.execSync(`elm make ${verifyDecodersFile} --output=/dev/null`, {
      stdio: "pipe"
    });
  } catch (error) {
    console.error(error.message);

    console.error(`--------------------------------------------
        INVALID SCALAR DECODERS FILE
--------------------------------------------

Your custom scalar decoders module, \`${customDecodersModule}\`, is invalid.

This is because either:

1) This is the first time you've run this CLI with the \`--scalar-codecs\` option.
  In this case, get a valid file, you can start by copy-pasting \`${baseModule.join(
    "."
  )}.ScalarCodecs\`. Then change the module name to \`${customDecodersModule}\`
  and you have a valid starting point!
2) You added or renamed a Custom Scalar in your GraphQL schema.
   To handle the new Custom Scalar, you can copy the relevant entries from \`${customDecodersModule}\`.

Check the following:
    * You have a module called \`${customDecodersModule}\`
    * The module is somewhere in your elm path (check the \`source-directories\` in your \`elm.json\`)

    You must:
    * Have a type for every custom scalar
    * Expose each of these types
    * Expose a \`decoders\` value

    Above the dashes (----) there are some details that might help you debug the issue. Remember, you can always
    copy-paste the \`${baseModule.join(
      "."
    )}.ScalarCodecs\` module to get a valid file.

    After you've copy pasted the template file, or tried fixing the file,
    re-run this CLI command to make sure it is valid.
    `);
    process.exit(1);
  }
}

function writeGeneratedFiles(
  outputPath: string,
  generatedFile: {
    [s: string]: string;
  }
): Promise<void>[] {
  return Object.entries(generatedFile).map(([fileName, fileContents]) => {
    const filePath = path.join(outputPath, fileName);
    console.log(filePath);
    return fs.writeFile(filePath, targetComment + fileContents);
  });
}

function writeIntrospectionFile(baseModule: string[], outputPath: string) {
  fs.writeFileSync(
    prependBasePath("elm-graphql-metadata.json", baseModule, outputPath),
    `{"targetElmPackageVersion": "${elmPackageVersion}", "generatedByNpmPackageVersion": "${npmPackageVersion}"}`
  );
}
