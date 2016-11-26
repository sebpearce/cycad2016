module Main exposing (..)

import Msg exposing (Msg)
import Html exposing (program)
import Model exposing (..)
import Update exposing (..)
import View exposing (..)
import Subscriptions exposing (..)


-- MODEL


main : Program Never Model Msg.Msg
main =
    program
        { init = Model.init
        , view = View.view
        , update = Update.update
        , subscriptions = Subscriptions.subscriptions
        }
