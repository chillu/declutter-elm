module Models exposing (..)

import Material
import Date exposing (..)
import Time exposing (..)


type alias Model =
    { currentTime : Time
    , things : List Thing
    , draftThing : Thing
    , uid : Int
    , viewMode : ViewMode
    , mdl : Material.Model
    }


type alias Mdl =
    Material.Model


type alias Uid =
    Int


type alias Name =
    String


type alias Thing =
    { uid : Uid
    , name : Name
    , reminderAlias : Maybe ReminderAlias
    , reminderDate : Maybe Date
    }


type ViewMode
    = ViewModeList
    | ViewModeAdd


type ReminderAlias
    = ReminderNextWeek
    | ReminderNextMonth
    | ReminderThreeMonths
    | ReminderNever


newThing : Uid -> Thing
newThing uid =
    { uid = uid
    , name = ""
    , reminderAlias = Nothing
    , reminderDate = Nothing
    }
