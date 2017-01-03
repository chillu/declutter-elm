module Update exposing (..)

import Messages exposing (..)
import Models exposing (..)
import Material exposing (update)
import Date exposing (..)
import Date.Extra as DateExtra exposing (..)


reminderDateFromAlias : Date -> ReminderAlias -> Maybe Date
reminderDateFromAlias date reminderAlias =
    case reminderAlias of
        ReminderNextWeek ->
            Just (DateExtra.add Week 1 date)

        ReminderNextMonth ->
            Just (DateExtra.add Month 1 date)

        ReminderThreeMonths ->
            Just (DateExtra.add Month 3 date)

        ReminderNever ->
            Nothing


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetViewMode viewMode ->
            ( { model
                | viewMode = viewMode
              }
            , Cmd.none
            )

        -- http://stackoverflow.com/questions/38021777/how-do-i-get-the-current-time-in-elm-0-17-0-18
        -- https://medium.com/@lars.jacobsson81/dealing-with-time-in-elm-0-17-3af5274650fb#.9ppa1u6sp
        SetCurrentTime time ->
            ( { model
                | currentTime = time
              }
            , Cmd.none
            )

        UpdateReminder reminderAlias ->
            ( let
                draftThing =
                    model.draftThing
              in
                { model
                    | draftThing =
                        { draftThing
                            | reminderAlias =
                                Just reminderAlias
                            , reminderDate = (reminderDateFromAlias (fromTime model.currentTime) reminderAlias)
                        }
                }
            , Cmd.none
            )

        SetThingName name ->
            ( let
                draftThing =
                    model.draftThing
              in
                { model | draftThing = { draftThing | name = name } }
            , Cmd.none
            )

        Save ->
            ( let
                draftThing =
                    model.draftThing
              in
                { model
                    | uid = model.uid + 1
                    , things = model.things ++ [ { draftThing | uid = model.uid } ]
                    , draftThing = newThing model.uid
                    , viewMode = ViewModeList
                }
            , Cmd.none
            )

        Mdl msg_ ->
            Material.update Mdl msg_ model

        NoOp ->
            ( model, Cmd.none )
