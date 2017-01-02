module Models exposing (..)

import Material


type alias Model =
    { things : List Thing
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
    , reminderAlias : ReminderAlias
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
    , reminderAlias = ReminderNever
    }
