-- Do not manually edit this file, it was auto-generated by Graphqelm
-- https://github.com/dillonkearns/graphqelm


module Github.Object.DeletePullRequestReviewPayload exposing (..)

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
selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.DeletePullRequestReviewPayload
selection constructor =
    Object.selection constructor


typename__ : Field String Github.Object.DeletePullRequestReviewPayload
typename__ =
    Object.fieldDecoder "__typename" [] Decode.string


{-| A unique identifier for the client performing the mutation.
-}
clientMutationId : Field (Maybe String) Github.Object.DeletePullRequestReviewPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] (Decode.string |> Decode.nullable)


{-| The deleted pull request review.
-}
pullRequestReview : SelectionSet decodesTo Github.Object.PullRequestReview -> Field decodesTo Github.Object.DeletePullRequestReviewPayload
pullRequestReview object =
    Object.selectionField "pullRequestReview" [] object identity
