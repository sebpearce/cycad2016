module Modules.OnKeyDown exposing (..)

import Html exposing (Attribute)
import Html.Events exposing (on, keyCode, onInput)
import Json.Decode exposing (list, string)
import Msg exposing (..)


onKeyDown : (Int -> Msg) -> Attribute Msg
onKeyDown tagger =
    on "keydown" (Json.Decode.map tagger keyCode)
