module Init exposing (..)

import Model exposing (Model)
import Update
import Msg exposing (..)
import Dict
import Random.Pcg exposing (Seed, initialSeed)
import Modules.CompareEntries exposing (..)
import Modules.Transaction exposing (TransactionsForOneDay)


type alias Flags =
    { seed : Int
    , entries : List TransactionsForOneDay
    , categories : List ( Int, String )
    }


init : Flags -> ( Model, Cmd Msg )
init flags =
    let
        seed =
            flags.seed

        model =
            { allTransactions =
                { compare = compareEntries
                , entries = flags.entries
                }
            , categories = Dict.fromList (flags.categories)
            , capturedDate = 20161027
            , capturedAmt = 999
            , capturedDesc = "desc"
            , capturedCat = 2
            , currentSeed = initialSeed seed
            , currentUuid = ""
            }
    in
        Update.update NewUuid model
