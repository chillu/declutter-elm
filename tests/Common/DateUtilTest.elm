module Common.DateUtilTest exposing (..)

import Test exposing (..)
import Expect
import Common.DateUtil as DateUtil
import Date exposing (Month(..))
import Date.Extra as Date


all : Test
all =
    describe "relativeDate"
        [ test "Future date in a month" <|
            \() ->
                Expect.equal
                    (DateUtil.relativeDate
                        (Date.fromCalendarDate 2016 Jan 1)
                        (Date.fromCalendarDate 2016 Feb 1)
                    )
                    "in a month"
        , test "Future date in a week" <|
            \() ->
                Expect.equal
                    (DateUtil.relativeDate
                        (Date.fromCalendarDate 2016 Jan 1)
                        (Date.fromCalendarDate 2016 Jan 10)
                    )
                    "in a week"
        , test "Future date in less than a week" <|
            \() ->
                Expect.equal
                    (DateUtil.relativeDate
                        (Date.fromCalendarDate 2016 Jan 1)
                        (Date.fromCalendarDate 2016 Jan 2)
                    )
                    "in less than a week"
        ]
