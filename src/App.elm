module App exposing (..)

import Html exposing (..)
import Html.Attributes exposing (src, style, class)
import Material
import Material.Button as Button
import Material.Options as Options exposing (css)
import Material.Layout as Layout
import Material.Card as Card
import Material.Icon as Icon
import Material.Textfield as Textfield


-- MODEL


type alias Model =
    { things : List Thing
    , uid : Int
    , viewMode : ViewMode
    , mdl : Material.Model
    }


type alias Thing =
    { uid : Int
    , name : String
    }


type ViewMode
    = ViewModeList
    | ViewModeAdd


newThing : Int -> Thing
newThing uid =
    { uid = uid, name = "foo" }


init : String -> ( Model, Cmd Msg )
init flags =
    ( { things = []
      , uid = 0
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
    | Add


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetViewMode viewMode ->
            ( { model
                | viewMode = viewMode
              }
            , Cmd.none
            )

        Add ->
            ( { model
                | uid = model.uid + 1
                , things = model.things ++ [ newThing model.uid ]
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
        [ Textfield.render Mdl
            [ 1 ]
            model.mdl
            [ Textfield.label "Title" ]
            []
        , Button.render Mdl
            [ 0 ]
            model.mdl
            [ Button.raised
            , Button.colored
            , Options.onClick Add
            ]
            [ text "Add" ]
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
