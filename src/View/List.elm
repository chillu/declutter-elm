module View.List exposing (view)

import Models exposing (..)
import Messages exposing (..)
import Html exposing (..)
import Html.Attributes exposing (src, style, class)
import Html.Events exposing (onClick)
import Material.Button as Button
import Material.Options as Options exposing (css)
import Material.Icon as Icon
import Material.Card as Card
import Date exposing (..)
import Date.Extra as DateExtra


humanizeDate : Maybe Date -> String
humanizeDate date =
    case date of
        Just date ->
            DateExtra.toFormattedString "EEEE, MMMM d, y" date

        Nothing ->
            ""


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
    Card.view [ Options.attribute <| Html.Events.onClick (SetViewMode ViewModeEdit) ]
        [ Card.title []
            [ Card.head []
                [ text thing.name ]
            ]
        , Card.text [] [ text (humanizeDate thing.reminderDate) ]
        ]
