module Modules.Transaction exposing (..)

import Modules.DateAsInt exposing (..)


type alias Transaction =
    { id : String
    , amount : Float
    , description : String
    , category : Int
    }


type alias Transactions =
    List Transaction


type alias TransactionsForOneDay =
    ( DateAsInt, Transactions )
