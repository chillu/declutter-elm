module Main exposing (..)

import Update exposing (..)
import Models exposing (..)
import View exposing (..)
import Messages exposing (..)
import Material
import Html exposing (programWithFlags)


init : String -> ( Model, Cmd Msg )
init flags =
    ( { things = []
      , uid = 1
      , draftThing = newThing 0
      , viewMode = ViewModeList
      , mdl = Material.model
      }
    , Cmd.none
    )


main : Program String Model Msg
main =
    programWithFlags { view = view, init = init, update = update, subscriptions = subscriptions }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
