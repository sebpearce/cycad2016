module Components.RenderDate exposing (..)

import Date exposing (..)
import String


padWithZero : Int -> String
padWithZero num =
    if num < 10 then
        "0" ++ toString num
    else
        toString num


renderDate : Date -> String
renderDate date =
    let
        y =
            toString (year date)

        m =
            toString (month date)

        d =
            padWithZero (day date)
    in
        y ++ "-" ++ m ++ "-" ++ d
