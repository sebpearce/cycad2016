module Modules.Transaction exposing (..)

import Modules.DateAsInt exposing (..)


type alias TransactionWithDate =
    { id : String
    , amount : Float
    , date : Int
    , description : String
    , category_id : Int
    }


type alias Transaction =
    { id : String
    , amount : Float
    , description : Maybe String
    , category_id : Int
    }


type alias Transactions =
    List Transaction


type alias TransactionsForOneDay =
    ( DateAsInt, Transactions )
