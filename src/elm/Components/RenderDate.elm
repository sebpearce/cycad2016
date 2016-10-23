module Components.RenderDate exposing (..)

import Date exposing (..)
import String


renderDate : Date -> String
renderDate date =
    let
        y =
            toString (year date)

        m =
            toString (month date)

        d =
            toString (day date)
    in
        y ++ "-" ++ m ++ "-" ++ d
