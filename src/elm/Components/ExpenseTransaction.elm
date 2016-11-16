module Components.ExpenseTransaction exposing (..)

import Date exposing (..)


type alias ExpensesForOneDay =
    { date : Date
    , transactions : List ExpenseTransaction
    }


type alias ExpenseTransaction =
    { id : Int
    , amount : Float
    , description : String
    , category : Int
    }
