module View exposing (view)

import Models exposing (..)
import Messages exposing (..)
import Html exposing (..)
import Material.Layout as Layout
import View.Body as ViewBody


view : Model -> Html Msg
view model =
    Layout.render Mdl
        model.mdl
        [ Layout.fixedHeader
        ]
        { header =
            [ h3 [] [ text "Declutter" ] ]
        , drawer = []
        , tabs = ( [], [] )
        , main = [ ViewBody.view model ]
        }
