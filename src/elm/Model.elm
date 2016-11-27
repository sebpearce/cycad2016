module Model exposing (..)

import Modules.DictOfCategories exposing (DictOfCategories)
import Modules.Transaction exposing (..)
import Modules.CompareEntries exposing (..)
import Modules.Map exposing (..)
import Date exposing (..)
import Dict exposing (..)
import Msg exposing (..)


--
-- type alias CapturedRow =
--     { date : Date
--     , amount : Float
--     , description : String
--     , category : Int
--     }


type alias Model =
    { allTransactions : Map Date Transactions
    , categories : Dict Int String
    , capturedDate : Date
    , capturedAmt : Float
    , capturedDesc : String
    , capturedCat : Int
    }


generateDate : String -> Date
generateDate inputStr =
    Date.fromString inputStr |> Result.withDefault (Date.fromTime 0)


init : ( Model, Cmd Msg )
init =
    ( { allTransactions =
            { compare = compareEntries
            , entries =
                [ ( generateDate "2016/10/23"
                  , [ { id = 1, amount = -17.54, description = "stuff", category = 3 }
                    , { id = 2, amount = -15, description = "things", category = 1 }
                    , { id = 3, amount = 636, description = "", category = 5 }
                    ]
                  )
                , ( generateDate "2016/10/24"
                  , [ { id = 4, amount = -10111.23, description = "stuff", category = 3 }
                    , { id = 5, amount = -71, description = "things", category = 2 }
                    , { id = 6, amount = 4000, description = "", category = 4 }
                    , { id = 7, amount = -75.9, description = "", category = 2 }
                    ]
                  )
                , ( generateDate "2016/10/25"
                  , [ { id = 8, amount = -1650, description = "rent", category = 1 }
                    , { id = 9, amount = -19.99, description = "", category = 3 }
                    , { id = 10, amount = 5, description = "", category = 3 }
                    ]
                  )
                , ( generateDate "2016/10/26"
                  , [ { id = 11, amount = -250, description = "rent", category = 1 }
                    , { id = 12, amount = -8.8, description = "dumplings", category = 3 }
                    , { id = 13, amount = -7.5, description = "", category = 3 }
                    , { id = 14, amount = -24.05, description = "", category = 2 }
                    , { id = 15, amount = -131, description = "", category = 2 }
                    ]
                  )
                ]
            }
      , categories =
            Dict.fromList
                [ ( 1, "Rent" )
                , ( 2, "Groceries" )
                , ( 3, "Eating out" )
                , ( 4, "Salary" )
                , ( 5, "Partner's salary" )
                , ( 6, "Gifts" )
                ]
            -- , capturedRow =
            --       { date = generateDate "2016/10/27"
            --       , amount = 999
            --       , description = "desc"
            --       , category = 2
            --       }
      , capturedDate = generateDate "2016/10/27"
      , capturedAmt = 999
      , capturedDesc = "desc"
      , capturedCat = 2
      }
    , Cmd.none
    )
