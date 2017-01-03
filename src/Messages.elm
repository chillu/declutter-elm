module Messages exposing (..)

import Material exposing (Msg)
import Models exposing (..)
import Time exposing (Time)


type Msg
    = NoOp
    | Mdl (Material.Msg Msg)
    | SetViewMode ViewMode
    | UpdateReminder ReminderAlias
    | SetCurrentTime Time
    | SetThingName String
    | Save
