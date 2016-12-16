module Msg exposing (..)

import Modules.DateAsInt exposing (..)
import Http


type Msg
    = NoOp
    | Save
    | DeleteTransaction String
    | AddTransaction ( DateAsInt, Float, Int, Maybe String )
    | TransactionPersisted (Result Http.Error String)
    | UpdateCapturedDate String
    | UpdateCapturedAmt String
    | UpdateCapturedDesc String
    | UpdateCapturedCat String
    | NewUuid
