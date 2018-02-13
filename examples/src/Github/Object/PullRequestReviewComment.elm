-- Do not manually edit this file, it was auto-generated by Graphqelm
-- https://github.com/dillonkearns/graphqelm


module Github.Object.PullRequestReviewComment exposing (..)

import Github.Enum.CommentAuthorAssociation
import Github.Enum.CommentCannotUpdateReason
import Github.Enum.ReactionContent
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
selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.PullRequestReviewComment
selection constructor =
    Object.selection constructor


typename__ : Field String Github.Object.PullRequestReviewComment
typename__ =
    Object.fieldDecoder "__typename" [] Decode.string


{-| The actor who authored the comment.
-}
author : SelectionSet decodesTo Github.Interface.Actor -> Field (Maybe decodesTo) Github.Object.PullRequestReviewComment
author object =
    Object.selectionField "author" [] object (identity >> Decode.nullable)


{-| Author's association with the subject of the comment.
-}
authorAssociation : Field Github.Enum.CommentAuthorAssociation.CommentAuthorAssociation Github.Object.PullRequestReviewComment
authorAssociation =
    Object.fieldDecoder "authorAssociation" [] Github.Enum.CommentAuthorAssociation.decoder


{-| The comment body of this review comment.
-}
body : Field String Github.Object.PullRequestReviewComment
body =
    Object.fieldDecoder "body" [] Decode.string


{-| The comment body of this review comment rendered to HTML.
-}
bodyHTML : Field Github.Scalar.Html Github.Object.PullRequestReviewComment
bodyHTML =
    Object.fieldDecoder "bodyHTML" [] (Decode.oneOf [ Decode.string, Decode.float |> Decode.map toString, Decode.int |> Decode.map toString, Decode.bool |> Decode.map toString ] |> Decode.map Github.Scalar.Html)


{-| The comment body of this review comment rendered as plain text.
-}
bodyText : Field String Github.Object.PullRequestReviewComment
bodyText =
    Object.fieldDecoder "bodyText" [] Decode.string


{-| Identifies the commit associated with the comment.
-}
commit : SelectionSet decodesTo Github.Object.Commit -> Field decodesTo Github.Object.PullRequestReviewComment
commit object =
    Object.selectionField "commit" [] object identity


{-| Identifies when the comment was created.
-}
createdAt : Field Github.Scalar.DateTime Github.Object.PullRequestReviewComment
createdAt =
    Object.fieldDecoder "createdAt" [] (Decode.oneOf [ Decode.string, Decode.float |> Decode.map toString, Decode.int |> Decode.map toString, Decode.bool |> Decode.map toString ] |> Decode.map Github.Scalar.DateTime)


{-| Check if this comment was created via an email reply.
-}
createdViaEmail : Field Bool Github.Object.PullRequestReviewComment
createdViaEmail =
    Object.fieldDecoder "createdViaEmail" [] Decode.bool


{-| Identifies the primary key from the database.
-}
databaseId : Field (Maybe Int) Github.Object.PullRequestReviewComment
databaseId =
    Object.fieldDecoder "databaseId" [] (Decode.int |> Decode.nullable)


{-| The diff hunk to which the comment applies.
-}
diffHunk : Field String Github.Object.PullRequestReviewComment
diffHunk =
    Object.fieldDecoder "diffHunk" [] Decode.string


{-| Identifies when the comment was created in a draft state.
-}
draftedAt : Field Github.Scalar.DateTime Github.Object.PullRequestReviewComment
draftedAt =
    Object.fieldDecoder "draftedAt" [] (Decode.oneOf [ Decode.string, Decode.float |> Decode.map toString, Decode.int |> Decode.map toString, Decode.bool |> Decode.map toString ] |> Decode.map Github.Scalar.DateTime)


{-| The actor who edited the comment.
-}
editor : SelectionSet decodesTo Github.Interface.Actor -> Field (Maybe decodesTo) Github.Object.PullRequestReviewComment
editor object =
    Object.selectionField "editor" [] object (identity >> Decode.nullable)


id : Field Github.Scalar.Id Github.Object.PullRequestReviewComment
id =
    Object.fieldDecoder "id" [] (Decode.oneOf [ Decode.string, Decode.float |> Decode.map toString, Decode.int |> Decode.map toString, Decode.bool |> Decode.map toString ] |> Decode.map Github.Scalar.Id)


{-| The moment the editor made the last edit
-}
lastEditedAt : Field (Maybe Github.Scalar.DateTime) Github.Object.PullRequestReviewComment
lastEditedAt =
    Object.fieldDecoder "lastEditedAt" [] (Decode.oneOf [ Decode.string, Decode.float |> Decode.map toString, Decode.int |> Decode.map toString, Decode.bool |> Decode.map toString ] |> Decode.map Github.Scalar.DateTime |> Decode.nullable)


{-| Identifies the original commit associated with the comment.
-}
originalCommit : SelectionSet decodesTo Github.Object.Commit -> Field (Maybe decodesTo) Github.Object.PullRequestReviewComment
originalCommit object =
    Object.selectionField "originalCommit" [] object (identity >> Decode.nullable)


{-| The original line index in the diff to which the comment applies.
-}
originalPosition : Field Int Github.Object.PullRequestReviewComment
originalPosition =
    Object.fieldDecoder "originalPosition" [] Decode.int


{-| The path to which the comment applies.
-}
path : Field String Github.Object.PullRequestReviewComment
path =
    Object.fieldDecoder "path" [] Decode.string


{-| The line index in the diff to which the comment applies.
-}
position : Field (Maybe Int) Github.Object.PullRequestReviewComment
position =
    Object.fieldDecoder "position" [] (Decode.int |> Decode.nullable)


{-| Identifies when the comment was published at.
-}
publishedAt : Field (Maybe Github.Scalar.DateTime) Github.Object.PullRequestReviewComment
publishedAt =
    Object.fieldDecoder "publishedAt" [] (Decode.oneOf [ Decode.string, Decode.float |> Decode.map toString, Decode.int |> Decode.map toString, Decode.bool |> Decode.map toString ] |> Decode.map Github.Scalar.DateTime |> Decode.nullable)


{-| The pull request associated with this review comment.
-}
pullRequest : SelectionSet decodesTo Github.Object.PullRequest -> Field decodesTo Github.Object.PullRequestReviewComment
pullRequest object =
    Object.selectionField "pullRequest" [] object identity


{-| The pull request review associated with this review comment.
-}
pullRequestReview : SelectionSet decodesTo Github.Object.PullRequestReview -> Field (Maybe decodesTo) Github.Object.PullRequestReviewComment
pullRequestReview object =
    Object.selectionField "pullRequestReview" [] object (identity >> Decode.nullable)


{-| A list of reactions grouped by content left on the subject.
-}
reactionGroups : SelectionSet decodesTo Github.Object.ReactionGroup -> Field (Maybe (List decodesTo)) Github.Object.PullRequestReviewComment
reactionGroups object =
    Object.selectionField "reactionGroups" [] object (identity >> Decode.list >> Decode.nullable)


type alias ReactionsOptionalArguments =
    { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, content : OptionalArgument Github.Enum.ReactionContent.ReactionContent, orderBy : OptionalArgument Github.InputObject.ReactionOrder }


{-| A list of Reactions left on the Issue.

  - first - Returns the first _n_ elements from the list.
  - after - Returns the elements in the list that come after the specified global ID.
  - last - Returns the last _n_ elements from the list.
  - before - Returns the elements in the list that come before the specified global ID.
  - content - Allows filtering Reactions by emoji.
  - orderBy - Allows specifying the order in which reactions are returned.

-}
reactions : (ReactionsOptionalArguments -> ReactionsOptionalArguments) -> SelectionSet decodesTo Github.Object.ReactionConnection -> Field decodesTo Github.Object.PullRequestReviewComment
reactions fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, content = Absent, orderBy = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "content" filledInOptionals.content (Encode.enum Github.Enum.ReactionContent.toString), Argument.optional "orderBy" filledInOptionals.orderBy Github.InputObject.encodeReactionOrder ]
                |> List.filterMap identity
    in
    Object.selectionField "reactions" optionalArgs object identity


{-| The comment this is a reply to.
-}
replyTo : SelectionSet decodesTo Github.Object.PullRequestReviewComment -> Field (Maybe decodesTo) Github.Object.PullRequestReviewComment
replyTo object =
    Object.selectionField "replyTo" [] object (identity >> Decode.nullable)


{-| The repository associated with this node.
-}
repository : SelectionSet decodesTo Github.Object.Repository -> Field decodesTo Github.Object.PullRequestReviewComment
repository object =
    Object.selectionField "repository" [] object identity


{-| The HTTP path permalink for this review comment.
-}
resourcePath : Field Github.Scalar.Uri Github.Object.PullRequestReviewComment
resourcePath =
    Object.fieldDecoder "resourcePath" [] (Decode.oneOf [ Decode.string, Decode.float |> Decode.map toString, Decode.int |> Decode.map toString, Decode.bool |> Decode.map toString ] |> Decode.map Github.Scalar.Uri)


{-| Identifies when the comment was last updated.
-}
updatedAt : Field Github.Scalar.DateTime Github.Object.PullRequestReviewComment
updatedAt =
    Object.fieldDecoder "updatedAt" [] (Decode.oneOf [ Decode.string, Decode.float |> Decode.map toString, Decode.int |> Decode.map toString, Decode.bool |> Decode.map toString ] |> Decode.map Github.Scalar.DateTime)


{-| The HTTP URL permalink for this review comment.
-}
url : Field Github.Scalar.Uri Github.Object.PullRequestReviewComment
url =
    Object.fieldDecoder "url" [] (Decode.oneOf [ Decode.string, Decode.float |> Decode.map toString, Decode.int |> Decode.map toString, Decode.bool |> Decode.map toString ] |> Decode.map Github.Scalar.Uri)


type alias UserContentEditsOptionalArguments =
    { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }


{-| A list of edits to this content.

  - first - Returns the first _n_ elements from the list.
  - after - Returns the elements in the list that come after the specified global ID.
  - last - Returns the last _n_ elements from the list.
  - before - Returns the elements in the list that come before the specified global ID.

-}
userContentEdits : (UserContentEditsOptionalArguments -> UserContentEditsOptionalArguments) -> SelectionSet decodesTo Github.Object.UserContentEditConnection -> Field (Maybe decodesTo) Github.Object.PullRequestReviewComment
userContentEdits fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionField "userContentEdits" optionalArgs object (identity >> Decode.nullable)


{-| Check if the current viewer can delete this object.
-}
viewerCanDelete : Field Bool Github.Object.PullRequestReviewComment
viewerCanDelete =
    Object.fieldDecoder "viewerCanDelete" [] Decode.bool


{-| Can user react to this subject
-}
viewerCanReact : Field Bool Github.Object.PullRequestReviewComment
viewerCanReact =
    Object.fieldDecoder "viewerCanReact" [] Decode.bool


{-| Check if the current viewer can update this object.
-}
viewerCanUpdate : Field Bool Github.Object.PullRequestReviewComment
viewerCanUpdate =
    Object.fieldDecoder "viewerCanUpdate" [] Decode.bool


{-| Reasons why the current viewer can not update this comment.
-}
viewerCannotUpdateReasons : Field (List Github.Enum.CommentCannotUpdateReason.CommentCannotUpdateReason) Github.Object.PullRequestReviewComment
viewerCannotUpdateReasons =
    Object.fieldDecoder "viewerCannotUpdateReasons" [] (Github.Enum.CommentCannotUpdateReason.decoder |> Decode.list)


{-| Did the viewer author this comment.
-}
viewerDidAuthor : Field Bool Github.Object.PullRequestReviewComment
viewerDidAuthor =
    Object.fieldDecoder "viewerDidAuthor" [] Decode.bool
