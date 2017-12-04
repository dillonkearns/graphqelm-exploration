module Generator.ObjectTypesTests exposing (all)

import Expect
import Graphqelm.Generator.ObjectTypes as ObjectTypes
import Graphqelm.Parser.Type as Type exposing (..)
import Test exposing (..)


definitions : List a
definitions =
    []


all : Test
all =
    describe "object types generator"
        [ test "enum has no object definitions" <|
            \() ->
                [ Type.TypeDefinition "Weather" (Type.EnumType [ "CLOUDY", "SUNNY" ]) ]
                    |> ObjectTypes.generate
                    |> Expect.equal
                        """module Api.Object exposing (..)


placeholder : String
placeholder =
    ""
"""
        , test "generates imports for objects and interfaces" <|
            \() ->
                [ Type.TypeDefinition "MyObject"
                    (Type.ObjectType [])
                , Type.TypeDefinition "MyInterface"
                    (Type.InterfaceType [])
                ]
                    |> ObjectTypes.generate
                    |> Expect.equal """module Api.Object exposing (..)


type MyObject
    = MyObject


type MyInterface
    = MyInterface
"""
        ]
