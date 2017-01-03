module Main exposing (..)

import Update exposing (..)
import Models exposing (..)
import View exposing (..)
import Messages exposing (..)
import Material
import Html exposing (programWithFlags)
import Time exposing (..)


init : String -> ( Model, Cmd Msg )
init flags =
    ( { currentTime = 0
      , things = []
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
    Sub.batch
        -- https://medium.com/@lars.jacobsson81/dealing-with-time-in-elm-0-17-3af5274650fb#.9ppa1u6sp
        [ Time.every Time.second SetCurrentTime
        ]
