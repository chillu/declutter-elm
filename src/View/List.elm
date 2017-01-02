module View.List exposing (view)

import Models exposing (..)
import Messages exposing (..)
import Html exposing (..)
import Html.Attributes exposing (src, style, class)
import Material.Button as Button
import Material.Options as Options exposing (css)
import Material.Icon as Icon
import Material.Card as Card


view : Model -> Html Msg
view model =
    div
        []
        [ Button.render Mdl
            [ 0 ]
            model.mdl
            [ Button.fab
            , Button.colored
            , Options.onClick (SetViewMode ViewModeAdd)
            , Options.attribute <| class "add"
            ]
            [ Icon.i "add" ]
        , viewCards model.things
        ]


viewCards : List Thing -> Html Msg
viewCards things =
    div [] <| List.map viewCard things


viewCard : Thing -> Html Msg
viewCard thing =
    Card.view []
        [ Card.title []
            [ Card.head []
                [ text thing.name ]
            ]
        ]
