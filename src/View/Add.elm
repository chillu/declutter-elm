module View.Add exposing (view)

import Models exposing (..)
import Messages exposing (..)
import Html exposing (..)
import Html.Events exposing (Options)
import Material.Toggles as Toggles
import Material.Textfield as Textfield
import Material.Button as Button
import Material.Options as Options exposing (css)
import Json.Decode as Json


preventDefault : Options
preventDefault =
    { stopPropagation = True
    , preventDefault = True
    }


view : Model -> Html Msg
view model =
    div
        []
        [ viewForm model.draftThing model.mdl ]


viewForm : Thing -> Mdl -> Html Msg
viewForm thing mdl =
    form []
        [ p []
            [ Textfield.render Mdl
                [ 1 ]
                mdl
                [ Textfield.label "Title"
                , Options.onInput SetThingName
                ]
                []
            ]
        , p []
            [ Toggles.radio Mdl
                [ 2 ]
                mdl
                [ Toggles.value (Just ReminderNextWeek == thing.reminderAlias)
                , Toggles.group "ReminderAlias"
                , Toggles.ripple
                , Options.onToggle (UpdateReminder ReminderNextWeek)
                ]
                [ text "Next Week" ]
            , Toggles.radio Mdl
                [ 3 ]
                mdl
                [ css "margin-left" "2rem"
                , Toggles.value (Just ReminderNextMonth == thing.reminderAlias)
                , Toggles.group "ReminderAlias"
                , Toggles.ripple
                , Options.onToggle (UpdateReminder ReminderNextMonth)
                ]
                [ text "Next Month" ]
            , Toggles.radio Mdl
                [ 4 ]
                mdl
                [ css "margin-left" "2rem"
                , Toggles.value (Just ReminderNever == thing.reminderAlias)
                , Toggles.group "ReminderAlias"
                , Toggles.ripple
                , Options.onToggle (UpdateReminder ReminderNever)
                ]
                [ text "Never" ]
            ]
        , p []
            [ Button.render Mdl
                [ 0 ]
                mdl
                [ Button.raised
                , Button.colored
                , Options.onWithOptions "click" preventDefault (Json.succeed Save)
                ]
                [ text "Add" ]
            ]
        ]
