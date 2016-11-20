module Model exposing (..)

import Modules.DictOfCategories exposing (DictOfCategories)
import Modules.Transaction exposing (Transaction, TransactionsForOneDay)
import Date exposing (..)
import Dict exposing (..)
import Msg exposing (Msg)


type alias Model =
    { transactions : List TransactionsForOneDay
    , categories : DictOfCategories
    }


init : ( Model, Cmd Msg )
init =
    ( { transactions =
            [ { date = Date.fromString "2016/10/23" |> Result.withDefault (Date.fromTime 0)
              , transactions =
                    [ { id = 1, amount = -17.54, description = "stuff", category = 3 }
                    , { id = 2, amount = -15, description = "things", category = 1 }
                    , { id = 3, amount = 636, description = "", category = 5 }
                    ]
              }
            , { date = Date.fromString "2016/10/24" |> Result.withDefault (Date.fromTime 0)
              , transactions =
                    [ { id = 4, amount = -10111.23, description = "stuff", category = 3 }
                    , { id = 5, amount = -71, description = "things", category = 2 }
                    , { id = 6, amount = 4000, description = "", category = 4 }
                    , { id = 7, amount = -75.9, description = "", category = 2 }
                    ]
              }
            , { date = Date.fromString "2016/10/25" |> Result.withDefault (Date.fromTime 0)
              , transactions =
                    [ { id = 8, amount = -1650, description = "rent", category = 1 }
                    , { id = 9, amount = -19.99, description = "", category = 3 }
                    , { id = 10, amount = 5, description = "", category = 3 }
                    ]
              }
            , { date = Date.fromString "2016/10/26" |> Result.withDefault (Date.fromTime 0)
              , transactions =
                    [ { id = 11, amount = -250, description = "rent", category = 1 }
                    , { id = 12, amount = -8.8, description = "dumplings", category = 3 }
                    , { id = 13, amount = -7.5, description = "", category = 3 }
                    , { id = 14, amount = -24.15, description = "", category = 2 }
                    , { id = 15, amount = -131, description = "", category = 2 }
                    ]
              }
            ]
      , categories =
            Dict.fromList
                [ ( 1, "Rent" )
                , ( 2, "Groceries" )
                , ( 3, "Eating out" )
                , ( 4, "Salary" )
                , ( 5, "Partner's salary" )
                , ( 6, "Gifts" )
                ]
      }
    , Cmd.none
    )
