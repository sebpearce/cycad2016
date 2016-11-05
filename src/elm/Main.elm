module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App exposing (beginnerProgram)
import Date exposing (..)


-- import Html.Events exposing (onInput)
-- import String exposing (toList, fromList)
-- import Char exposing (toCode, fromCode)

import List exposing (map)
import Components.RenderDate exposing (renderDate)


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
        [ { id = 1
          , name = "Rent"
          }
        , { id = 2
          , name = "Groceries"
          }
        , { id = 3
          , name = "Eating out"
          }
        ]
    , incomeCategories =
        [ { id = 1
          , name = "Salary"
          }
        , { id = 2
          , name = "Partner's salary"
          }
        , { id = 3
          , name = "Gifts"
          }
        ]
    }


type alias Model =
    { expenseTransactions : List ExpensesForOneDay
    , incomeTransactions : List IncomeTransaction
    , expenseCategories : List ExpenseCategory
    , incomeCategories : List IncomeCategory
    }


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


type alias IncomeTransaction =
    { id : Int
    , date : Date
    , amount : Float
    , description : String
    , category : Int
    }


type alias IncomeCategory =
    { id : Int
    , name : String
    }


type alias ExpenseCategory =
    { id : Int
    , name : String
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


renderExpenseRow : ExpenseTransaction -> Html msg
renderExpenseRow transaction =
    div [ class "expense-day__row" ]
        [ div [ class "expense-day__row__amt" ] [ text (toString transaction.amount) ]
        , div [ class "expense-day__row__cat" ] [ text (toString transaction.category) ]
        , div [ class "expense-day__row__desc" ] [ text transaction.description ]
        ]


renderExpensesForOneDay : ExpensesForOneDay -> Html msg
renderExpensesForOneDay day =
    let
        dayTransactions =
            List.map renderExpenseRow day.transactions
    in
        div [ class "expense-day" ]
            [ div [ class "expense-day__date" ] [ text (renderDate day.date) ]
            , div [ class "expense-day__transactions" ]
                dayTransactions
            ]


renderExpensesTable : List ExpensesForOneDay -> Html msg
renderExpensesTable days =
    let
        renderedDays =
            List.map renderExpensesForOneDay days
    in
        table [] renderedDays


view : Model -> Html msg
view model =
    div [ class "container" ]
        [ h1 [] [ text "Cycad" ]
        , renderExpensesTable model.expenseTransactions
        ]
