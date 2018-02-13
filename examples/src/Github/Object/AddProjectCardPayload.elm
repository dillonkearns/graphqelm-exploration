-- Do not manually edit this file, it was auto-generated by Graphqelm
-- https://github.com/dillonkearns/graphqelm


module Github.Object.AddProjectCardPayload exposing (..)

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
selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.AddProjectCardPayload
selection constructor =
    Object.selection constructor


typename__ : Field String Github.Object.AddProjectCardPayload
typename__ =
    Object.fieldDecoder "__typename" [] Decode.string


{-| The edge from the ProjectColumn's card connection.
-}
cardEdge : SelectionSet decodesTo Github.Object.ProjectCardEdge -> Field decodesTo Github.Object.AddProjectCardPayload
cardEdge object =
    Object.selectionField "cardEdge" [] object identity


{-| A unique identifier for the client performing the mutation.
-}
clientMutationId : Field (Maybe String) Github.Object.AddProjectCardPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] (Decode.string |> Decode.nullable)


{-| The ProjectColumn
-}
projectColumn : SelectionSet decodesTo Github.Object.Project -> Field decodesTo Github.Object.AddProjectCardPayload
projectColumn object =
    Object.selectionField "projectColumn" [] object identity
