module Messages exposing (..)

import Material exposing (Msg)
import Models exposing (..)


type Msg
    = NoOp
    | Mdl (Material.Msg Msg)
    | SetViewMode ViewMode
    | UpdateReminder ReminderAlias
    | SetThingName String
    | Save
