module App exposing (..)

import Html exposing (..)
import Html.Attributes exposing (src, style, class)
import Html.Events exposing (Options)
import Material
import Material.Button as Button
import Material.Options as Options exposing (css)
import Material.Layout as Layout
import Material.Card as Card
import Material.Icon as Icon
import Material.Textfield as Textfield
import Json.Decode as Json


-- MODEL


type alias Model =
    { things : List Thing
    , draftThing : Thing
    , uid : Int
    , viewMode : ViewMode
    , mdl : Material.Model
    }


type alias Uid =
    Int


type alias Name =
    String


type alias Thing =
    { uid : Uid
    , name : Name
    }


type ViewMode
    = ViewModeList
    | ViewModeAdd


newThing : Uid -> Thing
newThing uid =
    { uid = uid, name = "" }


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



-- ACTION, UPDATE


type Msg
    = NoOp
    | Mdl (Material.Msg Msg)
    | SetViewMode ViewMode
    | SetThingName String
    | Save


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetViewMode viewMode ->
            ( { model
                | viewMode = viewMode
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



-- VIEW


type alias Mdl =
    Material.Model


preventDefault : Options
preventDefault =
    { stopPropagation = True
    , preventDefault = True
    }


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
        , main = [ viewBody model ]
        }


viewBody : Model -> Html Msg
viewBody model =
    case model.viewMode of
        ViewModeAdd ->
            div [] [ viewBodyAdd model ]

        ViewModeList ->
            div [] [ viewBodyList model ]


viewBodyList : Model -> Html Msg
viewBodyList model =
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


viewBodyAdd : Model -> Html Msg
viewBodyAdd model =
    div
        []
        [ viewForm model.draftThing model.mdl ]


viewForm : Thing -> Mdl -> Html Msg
viewForm thing mdl =
    form []
        [ Textfield.render Mdl
            [ 1 ]
            mdl
            [ Textfield.label "Title"
            , Options.onInput SetThingName
            ]
            []
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


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
