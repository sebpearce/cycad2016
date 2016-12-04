module Msg exposing (..)

import Modules.Transaction exposing (..)
import Modules.DateAsInt exposing (..)


type Msg
    = NoOp
    | Save
    | DeleteTransaction String
    | AddTransaction ( DateAsInt, Float, Int, String )
    | UpdateCapturedDate String
    | UpdateCapturedAmt String
    | UpdateCapturedDesc String
    | UpdateCapturedCat String
    | NewUuid
