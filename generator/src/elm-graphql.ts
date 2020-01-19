// Suppress elm warnings as we can't create production build with parcel using --no-minify
const warnOriginal = console.warn;
console.warn = function () {};

const {Elm} = require("./Main.elm");
import * as fs from "fs-extra";
import {GraphQLClient} from "graphql-request";
import * as http from "http";
import * as request from "request";
import {applyElmFormat} from "./formatted-write";
import {introspectionQuery} from "./introspection-query";
import * as glob from "glob";
import * as path from "path";
import * as childProcess from "child_process";
import {
  removeGenerated,
  isGenerated,
  warnAndExitIfContainsNonGenerated,
  generateOrExitIntrospectionFileFromSchema
} from "./cli/generated-code-handler";
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

let app = Elm.Main.init({flags: {argv: process.argv, versionMessage}});

console.warn = warnOriginal;

// app.ports.print.subscribe(console.log);
app.ports.printAndExitFailure.subscribe((message: string) => {
  console.log(message);
  process.exit(1);
});
app.ports.printAndExitSuccess.subscribe((message: string) => {
  console.log(message);
  process.exit(0);
});

app.ports.schemaFromFile.subscribe(
  ({
    schemaFilePath,
    outputPath,
    baseModule,
    customDecodersModule,
    compilerPath,
  }: {
    schemaFilePath: string;
    outputPath: string;
    baseModule: string[];
    customDecodersModule: string | null;
    compilerPath: string;
  }) => {
    warnAndExitIfContainsNonGenerated({baseModule, outputPath});
    const introspectionFileJson = generateOrExitIntrospectionFileFromSchema(schemaFilePath);

    onDataAvailable(
      introspectionFileJson,
      outputPath,
      baseModule,
      customDecodersModule,
      compilerPath
    );
  }
);

app.ports.introspectSchemaFromFile.subscribe(
  ({
    introspectionFilePath,
    outputPath,
    baseModule,
    customDecodersModule,
    compilerPath
  }: {
    introspectionFilePath: string;
    outputPath: string;
    baseModule: string[];
    customDecodersModule: string | null;
    compilerPath: string;
  }) => {
    warnAndExitIfContainsNonGenerated({baseModule, outputPath});
    const introspectionFileJson = JSON.parse(
      fs.readFileSync(introspectionFilePath).toString()
    );
    onDataAvailable(
      introspectionFileJson.data || introspectionFileJson,
      outputPath,
      baseModule,
      customDecodersModule,
      compilerPath
    );
  }
);

app.ports.introspectSchemaFromUrl.subscribe(
  ({
    graphqlUrl,
    excludeDeprecated,
    outputPath,
    baseModule,
    headers,
    customDecodersModule,
    compilerPath
  }: {
    graphqlUrl: string;
    excludeDeprecated: boolean;
    outputPath: string;
    baseModule: string[];
    headers: {};
    customDecodersModule: string | null;
    compilerPath: string;
  }) => {
    warnAndExitIfContainsNonGenerated({baseModule, outputPath});

    console.log("Fetching GraphQL schema...");
    new GraphQLClient(graphqlUrl, {
      mode: "cors",
      headers: headers
    })
      .request(introspectionQuery, {includeDeprecated: !excludeDeprecated})
      .then(data => {
        onDataAvailable(data, outputPath, baseModule, customDecodersModule, compilerPath);
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
  outputPath: string,
  baseModule: string[],
  customDecodersModule: string | null,
  compilerPath: string,
) {
  console.log("Generating files...");
  app.ports.generatedFiles.subscribe(async function (generatedFile: {
    [s: string]: string;
  }) {
    removeGenerated(prependBasePath("/", baseModule, outputPath));
    makeEmptyDirectories(baseModule, outputPath, [
      "InputObject",
      "Object",
      "Interface",
      "Union",
      "Enum"
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
        customDecodersModule,
        compilerPath
      );
    }
    console.log("Success!");
  });
  app.ports.generateFiles.send(data);
}

function verifyCustomCodecsFileIsValid(
  outputPath: string,
  baseModule: string[],
  customDecodersModule: string,
  compilerPath: string,
) {
  const verifyDecodersFile = path.join(
    outputPath,
    ...baseModule,
    "VerifyScalarCodecs.elm"
  );

  if (compilerPath == 'elm') {
    try {
      childProcess.execSync('elm --version');
    } catch (error) {
      console.error(
        `Cannot find elm executable, make sure it is installed.
(If elm is not on your path or is called something different, try using the --compiler flag.)`
      );

      process.exit(1);
    }
  } else {
    try {
      childProcess.execSync(`${compilerPath} --version`)
    } catch (error) {
      console.error('The --compiler option must be given a path to an elm executable.');

      process.exit(1);
    }
  }

  try {
    childProcess.execSync(`${compilerPath} make ${verifyDecodersFile} --output=/dev/null`, {
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
    return fs.writeFile(filePath, targetComment + fileContents);
  });
}

function writeIntrospectionFile(baseModule: string[], outputPath: string) {
  fs.writeFileSync(
    prependBasePath("elm-graphql-metadata.json", baseModule, outputPath),
    `{"targetElmPackageVersion": "${elmPackageVersion}", "generatedByNpmPackageVersion": "${npmPackageVersion}"}`
  );
}
