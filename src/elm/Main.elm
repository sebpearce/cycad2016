module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App exposing (beginnerProgram)
import Date exposing (..)
import Dict exposing (..)


-- import Html.Events exposing (onInput)

import Model exposing (..)
import Components.ExpensesTable exposing (renderExpensesTable)


-- MODEL


main : Program Never
main =
    beginnerProgram { model = initialModel, view = view, update = update }


initialModel : Model
initialModel =
    { expenseTransactions =
        [ { date = Date.fromString "2016/10/23" |> Result.withDefault (Date.fromTime 0)
          , transactions =
                [ { id = 1
                  , amount = 17.54
                  , description = "stuff"
                  , category = 3
                  }
                , { id = 2
                  , amount = 15.0
                  , description = "things"
                  , category = 4
                  }
                ]
          }
        , { date = Date.fromString "2016/10/24" |> Result.withDefault (Date.fromTime 0)
          , transactions =
                [ { id = 1
                  , amount = 1.23
                  , description = "stuff"
                  , category = 3
                  }
                , { id = 2
                  , amount = 71.0
                  , description = "things"
                  , category = 4
                  }
                ]
          }
        ]
    , incomeTransactions =
        [ { id = 1
          , date = Date.fromString "2016/10/15" |> Result.withDefault (Date.fromTime 0)
          , amount = 4000.0
          , description = ""
          , category = 1
          }
        , { id = 2
          , date = Date.fromString "2016/10/20" |> Result.withDefault (Date.fromTime 0)
          , amount = 636.0
          , description = ""
          , category = 2
          }
        ]
    , expenseCategories =
        Dict.fromList [ ( 1, "Rent" ), ( 2, "Groceries" ), ( 3, "Eating out" ) ]
    , incomeCategories =
        Dict.fromList [ ( 1, "Salary" ), ( 2, "Partner's salary" ), ( 3, "Gifts" ) ]
    }



-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model



-- VIEW


view : Model -> Html msg
view model =
    div [ class "main-container" ]
        [ renderExpensesTable model ]
