module Init exposing (init)

import Model
import Update
import Msg exposing (..)
import Dict
import Random.Pcg exposing (Seed, initialSeed)
import Modules.CompareEntries exposing (..)


init : Int -> ( Model.Model, Cmd Msg )
init seed =
    let
        model =
            { allTransactions =
                { compare = compareEntries
                , entries =
                    [ ( 20161023
                      , [ { id = "1", amount = -17.54, description = "stuff", category = 3 }
                        , { id = "2", amount = -15, description = "things", category = 1 }
                        , { id = "3", amount = 636, description = "", category = 5 }
                        ]
                      )
                    , ( 20161024
                      , [ { id = "4", amount = -10111.23, description = "stuff", category = 3 }
                        , { id = "5", amount = -71, description = "things", category = 2 }
                        , { id = "6", amount = 4000, description = "", category = 4 }
                        , { id = "7", amount = -75.9, description = "", category = 2 }
                        ]
                      )
                    , ( 20161025
                      , [ { id = "8", amount = -1650, description = "rent", category = 1 }
                        , { id = "9", amount = -19.99, description = "", category = 3 }
                        , { id = "10", amount = 5, description = "", category = 3 }
                        ]
                      )
                    , ( 20161026
                      , [ { id = "11", amount = -250, description = "rent", category = 1 }
                        , { id = "12", amount = -8.8, description = "dumplings", category = 3 }
                        , { id = "13", amount = -7.5, description = "", category = 3 }
                        , { id = "14", amount = -24.05, description = "", category = 2 }
                        , { id = "15", amount = -131, description = "", category = 2 }
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
            , capturedDate = 20161027
            , capturedAmt = 999
            , capturedDesc = "desc"
            , capturedCat = 2
            , currentSeed = initialSeed seed
            , currentUuid = ""
            }
    in
        Update.update NewUuid model
