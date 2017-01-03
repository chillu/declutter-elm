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
import Date.Extra as DateExtra
import Date exposing (..)
import Common.DateUtil as DateUtil exposing (relativeDate)


getCardSubtitle : Model -> Thing -> String
getCardSubtitle model thing =
    case thing.reminderDate of
        Just date ->
            relativeDate (fromTime model.currentTime) date

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
        , viewCards model model.things
        ]


viewCards : Model -> List Thing -> Html Msg
viewCards model things =
    div [] <| List.map (viewCard model) things


viewCard : Model -> Thing -> Html Msg
viewCard model thing =
    Card.view
        [ -- Options.attribute <| Html.Events.onClick (SetViewMode ViewModeEdit)
          Options.cs "thing"
        ]
        [ Card.title
            [ Options.cs "thing__title mdl-color-text--white"
            ]
            [ Card.head []
                [ text thing.name ]
            ]
        , Card.text [] [ text (getCardSubtitle model thing) ]
        ]
