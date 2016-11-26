module Msg exposing (..)

import Date exposing (..)


type Msg
    = NoOp
    | DeleteTransaction Int
    | AddTransaction Int Date Float Int String
