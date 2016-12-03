module Msg exposing (..)

import Modules.Transaction exposing (..)
import Modules.DateAsInt exposing (..)


type Msg
    = NoOp
    | DeleteTransaction String
    | AddTransaction ( DateAsInt, Transaction )
    | UpdateCapturedDate String
    | UpdateCapturedAmt String
    | UpdateCapturedDesc String
    | UpdateCapturedCat String
    | NewUuid
