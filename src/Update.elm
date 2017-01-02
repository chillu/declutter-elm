module Update exposing (..)

import Messages exposing (..)
import Models exposing (..)
import Material exposing (update)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetViewMode viewMode ->
            ( { model
                | viewMode = viewMode
              }
            , Cmd.none
            )

        UpdateReminder reminderAlias ->
            ( let
                draftThing =
                    model.draftThing
              in
                { model | draftThing = { draftThing | reminderAlias = reminderAlias } }
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
