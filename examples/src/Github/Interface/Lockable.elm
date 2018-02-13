-- Do not manually edit this file, it was auto-generated by Graphqelm
-- https://github.com/dillonkearns/graphqelm


module Github.Interface.Lockable exposing (..)

import Github.Enum.LockReason
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
import Graphqelm.SelectionSet exposing (FragmentSelectionSet(FragmentSelectionSet), SelectionSet(SelectionSet))
import Json.Decode as Decode


{-| Select only common fields from the interface.
-}
commonSelection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Interface.Lockable
commonSelection constructor =
    Object.selection constructor


{-| Select both common and type-specific fields from the interface.
-}
selection : (Maybe typeSpecific -> a -> constructor) -> List (FragmentSelectionSet typeSpecific Github.Interface.Lockable) -> SelectionSet (a -> constructor) Github.Interface.Lockable
selection constructor typeSpecificDecoders =
    Object.interfaceSelection typeSpecificDecoders constructor


typename__ : Field String Github.Interface.Lockable
typename__ =
    Object.fieldDecoder "__typename" [] Decode.string


onIssue : SelectionSet decodesTo Github.Object.Issue -> FragmentSelectionSet decodesTo Github.Interface.Lockable
onIssue (SelectionSet fields decoder) =
    FragmentSelectionSet "Issue" fields decoder


onPullRequest : SelectionSet decodesTo Github.Object.PullRequest -> FragmentSelectionSet decodesTo Github.Interface.Lockable
onPullRequest (SelectionSet fields decoder) =
    FragmentSelectionSet "PullRequest" fields decoder


{-| Reason that the conversation was locked.
-}
activeLockReason : Field (Maybe Github.Enum.LockReason.LockReason) Github.Interface.Lockable
activeLockReason =
    Object.fieldDecoder "activeLockReason" [] (Github.Enum.LockReason.decoder |> Decode.nullable)


{-| `true` if the object is locked
-}
locked : Field Bool Github.Interface.Lockable
locked =
    Object.fieldDecoder "locked" [] Decode.bool
