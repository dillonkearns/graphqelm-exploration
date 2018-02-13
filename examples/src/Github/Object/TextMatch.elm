-- Do not manually edit this file, it was auto-generated by Graphqelm
-- https://github.com/dillonkearns/graphqelm


module Github.Object.TextMatch exposing (..)

import Github.InputObject
import Github.Interface
import Github.Object
import Github.Scalar
import Github.Union
import Graphqelm.Field as Field exposing (Field)
import Graphqelm.Internal.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Internal.Builder.Object as Object
import Graphqelm.Internal.Encode as Encode exposing (Value)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


{-| Select fields to build up a SelectionSet for this object.
-}
selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.TextMatch
selection constructor =
    Object.selection constructor


typename__ : Field String Github.Object.TextMatch
typename__ =
    Object.fieldDecoder "__typename" [] Decode.string


{-| The specific text fragment within the property matched on.
-}
fragment : Field String Github.Object.TextMatch
fragment =
    Object.fieldDecoder "fragment" [] Decode.string


{-| Highlights within the matched fragment.
-}
highlights : SelectionSet decodesTo Github.Object.TextMatchHighlight -> Field (List (Maybe decodesTo)) Github.Object.TextMatch
highlights object =
    Object.selectionField "highlights" [] object (identity >> Decode.nullable >> Decode.list)


{-| The property matched on.
-}
property : Field String Github.Object.TextMatch
property =
    Object.fieldDecoder "property" [] Decode.string
