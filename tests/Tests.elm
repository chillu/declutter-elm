module Tests exposing (..)

import Test exposing (..)
import Expect
import String
import Common.DateUtilTest


all : Test
all =
    describe "declutter-elm"
        [ Common.DateUtilTest.all ]
