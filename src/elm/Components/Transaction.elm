module Components.Transaction exposing (..)

import Date exposing (..)


type alias TransactionsForOneDay =
    { date : Date
    , transactions : List Transaction
    }


type alias Transaction =
    { id : Int
    , amount : Float
    , description : String
    , category : Int
    }
