module Components.Helpers exposing (..)

import Html exposing (..)
import Date exposing (..)
import String exposing (..)


formatAsMoney : Float -> String
formatAsMoney amt =
    let
        cents =
            round (amt * 100)

        dollars =
            cents // 100

        leftside =
            separateThousands <| toString dollars

        rightside =
            renderCents <| cents - (dollars * 100)
    in
        leftside ++ "." ++ rightside


renderCents : Int -> String
renderCents x =
    if x < 10 then
        toString x ++ "0"
    else
        toString x


separateThousands : String -> String
separateThousands s =
    join "," <| chunkInThrees s


chunkInThrees : String -> List String
chunkInThrees s =
    if length s > 3 then
        List.append (chunkInThrees <| dropRight 3 s) [ (right 3 s) ]
    else
        [ s ]


renderAmount : Float -> Html msg
renderAmount amount =
    if amount >= 0 then
        text ("+" ++ formatAsMoney amount)
    else
        text ("–" ++ formatAsMoney (abs amount))


renderDate : Date -> String
renderDate date =
    let
        y =
            toString (year date)

        m =
            toString (month date)

        d =
            padWithZero (day date)

        weekday =
            toString <| Date.dayOfWeek (date)
    in
        weekday ++ ", " ++ d ++ " " ++ m ++ " " ++ y


padWithZero : Int -> String
padWithZero num =
    if num < 10 then
        "0" ++ toString num
    else
        toString num


applyColor : Float -> String
applyColor amount =
    if amount >= 0 then
        " -positive"
    else
        " -negative"
