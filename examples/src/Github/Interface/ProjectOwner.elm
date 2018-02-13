-- Do not manually edit this file, it was auto-generated by Graphqelm
-- https://github.com/dillonkearns/graphqelm


module Github.Interface.ProjectOwner exposing (..)

import Github.Enum.ProjectState
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
commonSelection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Interface.ProjectOwner
commonSelection constructor =
    Object.selection constructor


{-| Select both common and type-specific fields from the interface.
-}
selection : (Maybe typeSpecific -> a -> constructor) -> List (FragmentSelectionSet typeSpecific Github.Interface.ProjectOwner) -> SelectionSet (a -> constructor) Github.Interface.ProjectOwner
selection constructor typeSpecificDecoders =
    Object.interfaceSelection typeSpecificDecoders constructor


typename__ : Field String Github.Interface.ProjectOwner
typename__ =
    Object.fieldDecoder "__typename" [] Decode.string


onOrganization : SelectionSet decodesTo Github.Object.Organization -> FragmentSelectionSet decodesTo Github.Interface.ProjectOwner
onOrganization (SelectionSet fields decoder) =
    FragmentSelectionSet "Organization" fields decoder


onRepository : SelectionSet decodesTo Github.Object.Repository -> FragmentSelectionSet decodesTo Github.Interface.ProjectOwner
onRepository (SelectionSet fields decoder) =
    FragmentSelectionSet "Repository" fields decoder


id : Field Github.Scalar.Id Github.Interface.ProjectOwner
id =
    Object.fieldDecoder "id" [] (Decode.oneOf [ Decode.string, Decode.float |> Decode.map toString, Decode.int |> Decode.map toString, Decode.bool |> Decode.map toString ] |> Decode.map Github.Scalar.Id)


type alias ProjectRequiredArguments =
    { number : Int }


{-| Find project by number.

  - number - The project number to find.

-}
project : ProjectRequiredArguments -> SelectionSet decodesTo Github.Object.Project -> Field (Maybe decodesTo) Github.Interface.ProjectOwner
project requiredArgs object =
    Object.selectionField "project" [ Argument.required "number" requiredArgs.number Encode.int ] object (identity >> Decode.nullable)


type alias ProjectsOptionalArguments =
    { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, orderBy : OptionalArgument Github.InputObject.ProjectOrder, search : OptionalArgument String, states : OptionalArgument (List Github.Enum.ProjectState.ProjectState) }


{-| A list of projects under the owner.

  - first - Returns the first _n_ elements from the list.
  - after - Returns the elements in the list that come after the specified global ID.
  - last - Returns the last _n_ elements from the list.
  - before - Returns the elements in the list that come before the specified global ID.
  - orderBy - Ordering options for projects returned from the connection
  - search - Query to search projects by, currently only searching by name.
  - states - A list of states to filter the projects by.

-}
projects : (ProjectsOptionalArguments -> ProjectsOptionalArguments) -> SelectionSet decodesTo Github.Object.ProjectConnection -> Field decodesTo Github.Interface.ProjectOwner
projects fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, orderBy = Absent, search = Absent, states = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "orderBy" filledInOptionals.orderBy Github.InputObject.encodeProjectOrder, Argument.optional "search" filledInOptionals.search Encode.string, Argument.optional "states" filledInOptionals.states (Encode.enum Github.Enum.ProjectState.toString |> Encode.list) ]
                |> List.filterMap identity
    in
    Object.selectionField "projects" optionalArgs object identity


{-| The HTTP path listing owners projects
-}
projectsResourcePath : Field Github.Scalar.Uri Github.Interface.ProjectOwner
projectsResourcePath =
    Object.fieldDecoder "projectsResourcePath" [] (Decode.oneOf [ Decode.string, Decode.float |> Decode.map toString, Decode.int |> Decode.map toString, Decode.bool |> Decode.map toString ] |> Decode.map Github.Scalar.Uri)


{-| The HTTP URL listing owners projects
-}
projectsUrl : Field Github.Scalar.Uri Github.Interface.ProjectOwner
projectsUrl =
    Object.fieldDecoder "projectsUrl" [] (Decode.oneOf [ Decode.string, Decode.float |> Decode.map toString, Decode.int |> Decode.map toString, Decode.bool |> Decode.map toString ] |> Decode.map Github.Scalar.Uri)


{-| Can the current viewer create new projects on this owner.
-}
viewerCanCreateProjects : Field Bool Github.Interface.ProjectOwner
viewerCanCreateProjects =
    Object.fieldDecoder "viewerCanCreateProjects" [] Decode.bool
