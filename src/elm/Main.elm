module Main exposing (..)

import Msg exposing (Msg)
import Html exposing (..)
import Model exposing (..)
import Update exposing (..)
import View exposing (..)
import Subscriptions exposing (..)
import Init exposing (..)


-- MODEL


main : Program Int Model Msg.Msg
main =
    programWithFlags
        { init = Init.init
        , view = View.view
        , update = Update.update
        , subscriptions = Subscriptions.subscriptions
        }
