module Msg exposing (..)

import Modules.DateAsInt exposing (..)
import Http


type Msg
    = NoOp
    | Save
    | DeleteTransaction String
    | TransactionDeleted (Result Http.Error String)
    | AddTransaction ( DateAsInt, Float, Int, Maybe String )
    | TransactionPersisted (Result Http.Error String)
    | UpdateCapturedDate String
    | UpdateCapturedAmt String
    | UpdateCapturedDesc String
    | UpdateCapturedCat String
    | UpdateCategorySearch String
    | NewUuid
