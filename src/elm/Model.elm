module Model exposing (..)

import Components.DictOfCategories exposing (DictOfCategories)
import Components.Transaction exposing (Transaction, TransactionsForOneDay)


type alias Model =
    { transactions : List TransactionsForOneDay
    , categories : DictOfCategories
    }
