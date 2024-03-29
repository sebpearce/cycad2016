module Modules.Helpers exposing (..)

import Html exposing (..)
import Date exposing (..)
import String exposing (..)
import Modules.DateAsInt exposing (..)


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
        "0" ++ toString x
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


interpretAsDate : Int -> Date
interpretAsDate x =
    let
        dateString =
            toString x

        formattedString =
            String.slice 0 4 dateString ++ "-" ++ String.slice 4 6 dateString ++ "-" ++ String.slice 6 8 dateString
    in
        Date.fromString formattedString |> Result.withDefault (Date.fromTime 0)


renderDate : DateAsInt -> String
renderDate date =
    let
        dateAsDate =
            interpretAsDate date

        y =
            toString (year dateAsDate)

        m =
            toString (month dateAsDate)

        d =
            padWithZero (day dateAsDate)

        weekday =
            toString <| Date.dayOfWeek (dateAsDate)
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
