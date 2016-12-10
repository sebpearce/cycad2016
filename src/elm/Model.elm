module Model exposing (..)

import Modules.Transaction exposing (..)
import Modules.Map exposing (..)
import Modules.DateAsInt exposing (..)
import Dict exposing (..)
import Random.Pcg exposing (Seed, initialSeed)


type alias Model =
    { allTransactions : Map DateAsInt Transactions
    , categories : Dict Int String
    , capturedDate : DateAsInt
    , capturedAmt : Float
    , capturedDesc : Maybe String
    , capturedCat : Int
    , currentSeed : Seed
    , currentUuid : String
    }
