module View.Body exposing (view)

import Models exposing (..)
import Messages exposing (..)
import Html exposing (..)
import View.Add as ViewAdd
import View.List as ViewList


view : Model -> Html Msg
view model =
    case model.viewMode of
        ViewModeAdd ->
            div [] [ ViewAdd.view model ]

        ViewModeList ->
            div [] [ ViewList.view model ]
