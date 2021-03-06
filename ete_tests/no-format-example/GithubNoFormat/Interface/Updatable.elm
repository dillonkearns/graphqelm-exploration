-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql
module GithubNoFormat.Interface.Updatable exposing (..)

import Graphql.Internal.Builder.Argument as Argument exposing (Argument)
import Graphql.Internal.Builder.Object as Object
import Graphql.Operation exposing (RootMutation, RootQuery, RootSubscription)
import Graphql.SelectionSet exposing (FragmentSelectionSet(..), SelectionSet(..))
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import GithubNoFormat.Object
import GithubNoFormat.Interface
import GithubNoFormat.Union
import GithubNoFormat.Scalar
import GithubNoFormat.InputObject
import GithubNoFormat.ScalarCodecs
import Json.Decode as Decode
import Graphql.Internal.Encode as Encode exposing (Value)


type alias Fragments decodesTo =
    {
    onCommitComment : SelectionSet decodesTo GithubNoFormat.Object.CommitComment,
 onGistComment : SelectionSet decodesTo GithubNoFormat.Object.GistComment,
 onIssue : SelectionSet decodesTo GithubNoFormat.Object.Issue,
 onIssueComment : SelectionSet decodesTo GithubNoFormat.Object.IssueComment,
 onProject : SelectionSet decodesTo GithubNoFormat.Object.Project,
 onPullRequest : SelectionSet decodesTo GithubNoFormat.Object.PullRequest,
 onPullRequestReview : SelectionSet decodesTo GithubNoFormat.Object.PullRequestReview,
 onPullRequestReviewComment : SelectionSet decodesTo GithubNoFormat.Object.PullRequestReviewComment
    }


{-| Build an exhaustive selection of type-specific fragments.
-}
fragments :
      Fragments decodesTo
      -> SelectionSet decodesTo GithubNoFormat.Interface.Updatable
fragments selections____ =
    Object.exhaustiveFragmentSelection
        [
         Object.buildFragment "CommitComment" selections____.onCommitComment,
 Object.buildFragment "GistComment" selections____.onGistComment,
 Object.buildFragment "Issue" selections____.onIssue,
 Object.buildFragment "IssueComment" selections____.onIssueComment,
 Object.buildFragment "Project" selections____.onProject,
 Object.buildFragment "PullRequest" selections____.onPullRequest,
 Object.buildFragment "PullRequestReview" selections____.onPullRequestReview,
 Object.buildFragment "PullRequestReviewComment" selections____.onPullRequestReviewComment
        ]


{-| Can be used to create a non-exhaustive set of fragments by using the record
update syntax to add `SelectionSet`s for the types you want to handle.
-}
maybeFragments : Fragments (Maybe decodesTo)
maybeFragments =
    {
      onCommitComment = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing),
 onGistComment = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing),
 onIssue = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing),
 onIssueComment = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing),
 onProject = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing),
 onPullRequest = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing),
 onPullRequestReview = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing),
 onPullRequestReviewComment = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    }
{-| Check if the current viewer can update this object.
-}
viewerCanUpdate : SelectionSet Bool GithubNoFormat.Interface.Updatable
viewerCanUpdate =
      Object.selectionForField "Bool" "viewerCanUpdate" [] (Decode.bool)
