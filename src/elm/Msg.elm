module Msg exposing (..)

import Date exposing (..)
import Modules.Transaction exposing (..)


type Msg
    = NoOp
    | DeleteTransaction Int
    | AddTransaction ( Date, Transaction )
    | UpdateCapturedDate String
    | UpdateCapturedAmt String
    | UpdateCapturedDesc String
    | UpdateCapturedCat String
