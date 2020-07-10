-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Normalize.Union.CharacterUnion exposing (..)

import Graphql.Internal.Builder.Argument as Argument exposing (Argument)
import Graphql.Internal.Builder.Object as Object
import Graphql.Internal.Encode as Encode exposing (Value)
import Graphql.Operation exposing (RootMutation, RootQuery, RootSubscription)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet exposing (FragmentSelectionSet(..), SelectionSet(..))
import Json.Decode as Decode
import Normalize.InputObject
import Normalize.Interface
import Normalize.Object
import Normalize.Scalar
import Normalize.ScalarCodecs
import Normalize.Union


type alias Fragments decodesTo =
    { onHuman_ : SelectionSet decodesTo Normalize.Object.Human_
    , onDroid : SelectionSet decodesTo Normalize.Object.Droid
    }


{-| Build up a selection for this Union by passing in a Fragments record.
-}
fragments :
    Fragments decodesTo
    -> SelectionSet decodesTo Normalize.Union.CharacterUnion
fragments selections =
    Object.exhaustiveFragmentSelection
        [ Object.buildFragment "_human" selections.onHuman_
        , Object.buildFragment "Droid" selections.onDroid
        ]


{-| Can be used to create a non-exhaustive set of fragments by using the record
update syntax to add `SelectionSet`s for the types you want to handle.
-}
maybeFragments : Fragments (Maybe decodesTo)
maybeFragments =
    { onHuman_ = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onDroid = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    }
