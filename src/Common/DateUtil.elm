module Common.DateUtil exposing (..)

import Date exposing (Month(..))
import Date.Extra as Date


relativeDate : Date.Date -> Date.Date -> String
relativeDate fromDate toDate =
    let
        diffDays =
            Date.diff Date.Day fromDate toDate
    in
        if diffDays >= 31 then
            "in a month"
        else if diffDays >= 14 then
            "in two weeks"
        else if diffDays >= 7 then
            "in a week"
        else
            "in less than a week"
