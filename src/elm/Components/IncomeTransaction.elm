module Components.IncomeTransaction exposing (..)

import Date exposing (..)


type alias IncomeTransaction =
    { id : Int
    , date : Date
    , amount : Float
    , description : String
    , category : Int
    }
