module Graphql.Generator.RequiredArgs exposing (ArgResult, generate)

import GenerateSyntax
import Graphql.Generator.Context exposing (Context)
import Graphql.Generator.Decoder
import Graphql.Parser.CamelCaseName as CamelCaseName exposing (CamelCaseName)
import Graphql.Parser.Type as Type
import Result.Extra
import String.Interpolate exposing (interpolate)


type alias ArgResult =
    { annotation : String -> String
    , list : String
    , typeAlias : { body : String, suffix : String }
    }


generate : Context -> List Type.Arg -> Maybe ArgResult
generate context args =
    let
        requiredArgs : List RequiredArg
        requiredArgs =
            List.filterMap requiredArgOrNothing args
    in
    if requiredArgs == [] then
        Nothing

    else
        requiredArgs
            |> requiredArgsString context
            |> Result.toMaybe
            |> Maybe.map
                (\list ->
                    { annotation = \fieldName -> interpolate "{0}RequiredArguments" [ fieldName ]
                    , list = list
                    , typeAlias = { body = requiredArgsAnnotation context requiredArgs, suffix = "RequiredArguments" }
                    }
                )


type alias RequiredArg =
    { name : CamelCaseName
    , referrableType : Type.ReferrableType
    , typeRef : Type.TypeReference
    }


requiredArgOrNothing : Type.Arg -> Maybe RequiredArg
requiredArgOrNothing { name, typeRef } =
    case typeRef of
        Type.TypeReference referrableType Type.NonNullable ->
            Just
                { name = name
                , referrableType = referrableType
                , typeRef = typeRef
                }

        Type.TypeReference referrableType Type.Nullable ->
            Nothing


requiredArgsString : Context -> List RequiredArg -> Result String String
requiredArgsString context =
    List.map (requiredArgString context)
        >> Result.Extra.combine
        >> Result.map
            (\results ->
                "[ " ++ (results |> String.join ", ") ++ " ]"
            )


requiredArgString : Context -> RequiredArg -> Result String String
requiredArgString context { name, referrableType, typeRef } =
    Graphql.Generator.Decoder.generateEncoder context typeRef
        |> Result.map
            (\res ->
                interpolate
                    "Argument.required \"{0}\" requiredArgs.{1} ({2})"
                    [ name |> CamelCaseName.raw
                    , name |> CamelCaseName.normalized
                    , res
                    ]
            )


requiredArgsAnnotation : Context -> List RequiredArg -> String
requiredArgsAnnotation context requiredArgs =
    requiredArgs
        |> List.map (requiredArgAnnotation context)
        |> GenerateSyntax.typeAlias


requiredArgAnnotation : Context -> RequiredArg -> ( String, String )
requiredArgAnnotation context { name, typeRef } =
    ( name |> CamelCaseName.normalized
    , Graphql.Generator.Decoder.generateType context typeRef
    )
