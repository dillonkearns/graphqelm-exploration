-- Do not manually edit this file, it was auto-generated by Graphqelm
-- https://github.com/dillonkearns/graphqelm


module Github.Interface.UniformResourceLocatable exposing (..)

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
commonSelection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Interface.UniformResourceLocatable
commonSelection constructor =
    Object.selection constructor


{-| Select both common and type-specific fields from the interface.
-}
selection : (Maybe typeSpecific -> a -> constructor) -> List (FragmentSelectionSet typeSpecific Github.Interface.UniformResourceLocatable) -> SelectionSet (a -> constructor) Github.Interface.UniformResourceLocatable
selection constructor typeSpecificDecoders =
    Object.interfaceSelection typeSpecificDecoders constructor


typename__ : Field String Github.Interface.UniformResourceLocatable
typename__ =
    Object.fieldDecoder "__typename" [] Decode.string


onBot : SelectionSet decodesTo Github.Object.Bot -> FragmentSelectionSet decodesTo Github.Interface.UniformResourceLocatable
onBot (SelectionSet fields decoder) =
    FragmentSelectionSet "Bot" fields decoder


onCrossReferencedEvent : SelectionSet decodesTo Github.Object.CrossReferencedEvent -> FragmentSelectionSet decodesTo Github.Interface.UniformResourceLocatable
onCrossReferencedEvent (SelectionSet fields decoder) =
    FragmentSelectionSet "CrossReferencedEvent" fields decoder


onIssue : SelectionSet decodesTo Github.Object.Issue -> FragmentSelectionSet decodesTo Github.Interface.UniformResourceLocatable
onIssue (SelectionSet fields decoder) =
    FragmentSelectionSet "Issue" fields decoder


onMergedEvent : SelectionSet decodesTo Github.Object.MergedEvent -> FragmentSelectionSet decodesTo Github.Interface.UniformResourceLocatable
onMergedEvent (SelectionSet fields decoder) =
    FragmentSelectionSet "MergedEvent" fields decoder


onMilestone : SelectionSet decodesTo Github.Object.Milestone -> FragmentSelectionSet decodesTo Github.Interface.UniformResourceLocatable
onMilestone (SelectionSet fields decoder) =
    FragmentSelectionSet "Milestone" fields decoder


onOrganization : SelectionSet decodesTo Github.Object.Organization -> FragmentSelectionSet decodesTo Github.Interface.UniformResourceLocatable
onOrganization (SelectionSet fields decoder) =
    FragmentSelectionSet "Organization" fields decoder


onPullRequest : SelectionSet decodesTo Github.Object.PullRequest -> FragmentSelectionSet decodesTo Github.Interface.UniformResourceLocatable
onPullRequest (SelectionSet fields decoder) =
    FragmentSelectionSet "PullRequest" fields decoder


onPullRequestCommit : SelectionSet decodesTo Github.Object.PullRequestCommit -> FragmentSelectionSet decodesTo Github.Interface.UniformResourceLocatable
onPullRequestCommit (SelectionSet fields decoder) =
    FragmentSelectionSet "PullRequestCommit" fields decoder


onRelease : SelectionSet decodesTo Github.Object.Release -> FragmentSelectionSet decodesTo Github.Interface.UniformResourceLocatable
onRelease (SelectionSet fields decoder) =
    FragmentSelectionSet "Release" fields decoder


onRepository : SelectionSet decodesTo Github.Object.Repository -> FragmentSelectionSet decodesTo Github.Interface.UniformResourceLocatable
onRepository (SelectionSet fields decoder) =
    FragmentSelectionSet "Repository" fields decoder


onRepositoryTopic : SelectionSet decodesTo Github.Object.RepositoryTopic -> FragmentSelectionSet decodesTo Github.Interface.UniformResourceLocatable
onRepositoryTopic (SelectionSet fields decoder) =
    FragmentSelectionSet "RepositoryTopic" fields decoder


onReviewDismissedEvent : SelectionSet decodesTo Github.Object.ReviewDismissedEvent -> FragmentSelectionSet decodesTo Github.Interface.UniformResourceLocatable
onReviewDismissedEvent (SelectionSet fields decoder) =
    FragmentSelectionSet "ReviewDismissedEvent" fields decoder


onUser : SelectionSet decodesTo Github.Object.User -> FragmentSelectionSet decodesTo Github.Interface.UniformResourceLocatable
onUser (SelectionSet fields decoder) =
    FragmentSelectionSet "User" fields decoder


{-| The HTML path to this resource.
-}
resourcePath : Field Github.Scalar.Uri Github.Interface.UniformResourceLocatable
resourcePath =
    Object.fieldDecoder "resourcePath" [] (Decode.oneOf [ Decode.string, Decode.float |> Decode.map toString, Decode.int |> Decode.map toString, Decode.bool |> Decode.map toString ] |> Decode.map Github.Scalar.Uri)


{-| The URL to this resource.
-}
url : Field Github.Scalar.Uri Github.Interface.UniformResourceLocatable
url =
    Object.fieldDecoder "url" [] (Decode.oneOf [ Decode.string, Decode.float |> Decode.map toString, Decode.int |> Decode.map toString, Decode.bool |> Decode.map toString ] |> Decode.map Github.Scalar.Uri)
