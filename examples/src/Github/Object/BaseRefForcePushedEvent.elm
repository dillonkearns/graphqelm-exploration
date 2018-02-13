-- Do not manually edit this file, it was auto-generated by Graphqelm
-- https://github.com/dillonkearns/graphqelm


module Github.Object.BaseRefForcePushedEvent exposing (..)

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
selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.BaseRefForcePushedEvent
selection constructor =
    Object.selection constructor


typename__ : Field String Github.Object.BaseRefForcePushedEvent
typename__ =
    Object.fieldDecoder "__typename" [] Decode.string


{-| Identifies the actor who performed the event.
-}
actor : SelectionSet decodesTo Github.Interface.Actor -> Field (Maybe decodesTo) Github.Object.BaseRefForcePushedEvent
actor object =
    Object.selectionField "actor" [] object (identity >> Decode.nullable)


{-| Identifies the after commit SHA for the 'base_ref_force_pushed' event.
-}
afterCommit : SelectionSet decodesTo Github.Object.Commit -> Field (Maybe decodesTo) Github.Object.BaseRefForcePushedEvent
afterCommit object =
    Object.selectionField "afterCommit" [] object (identity >> Decode.nullable)


{-| Identifies the before commit SHA for the 'base_ref_force_pushed' event.
-}
beforeCommit : SelectionSet decodesTo Github.Object.Commit -> Field (Maybe decodesTo) Github.Object.BaseRefForcePushedEvent
beforeCommit object =
    Object.selectionField "beforeCommit" [] object (identity >> Decode.nullable)


{-| Identifies the date and time when the object was created.
-}
createdAt : Field Github.Scalar.DateTime Github.Object.BaseRefForcePushedEvent
createdAt =
    Object.fieldDecoder "createdAt" [] (Decode.oneOf [ Decode.string, Decode.float |> Decode.map toString, Decode.int |> Decode.map toString, Decode.bool |> Decode.map toString ] |> Decode.map Github.Scalar.DateTime)


id : Field Github.Scalar.Id Github.Object.BaseRefForcePushedEvent
id =
    Object.fieldDecoder "id" [] (Decode.oneOf [ Decode.string, Decode.float |> Decode.map toString, Decode.int |> Decode.map toString, Decode.bool |> Decode.map toString ] |> Decode.map Github.Scalar.Id)


{-| PullRequest referenced by event.
-}
pullRequest : SelectionSet decodesTo Github.Object.PullRequest -> Field decodesTo Github.Object.BaseRefForcePushedEvent
pullRequest object =
    Object.selectionField "pullRequest" [] object identity


{-| Identifies the fully qualified ref name for the 'base_ref_force_pushed' event.
-}
ref : SelectionSet decodesTo Github.Object.Ref -> Field (Maybe decodesTo) Github.Object.BaseRefForcePushedEvent
ref object =
    Object.selectionField "ref" [] object (identity >> Decode.nullable)
