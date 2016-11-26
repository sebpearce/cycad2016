module Modules.Transaction exposing (..)

import Date exposing (..)


type alias Transaction =
    { id : Int
    , amount : Float
    , description : String
    , category : Int
    }


type alias Transactions =
    List Transaction


type alias TransactionsForOneDay =
    ( Date, Transactions )
