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
          , amount = 17.54
          , description = "stuff"
          , category = 3
          }
        , { date = Date.fromString "2016/10/22" |> Result.withDefault (Date.fromTime 0)
          , amount = 15.0
          , description = "things"
          , category = 4
          }
        ]
    , incomeTransactions =
        [ { date = Date.fromString "2016/10/15" |> Result.withDefault (Date.fromTime 0)
          , amount = 4000.0
          , description = ""
          , category = 1
          }
        , { date = Date.fromString "2016/10/20" |> Result.withDefault (Date.fromTime 0)
          , amount = 636.0
          , description = ""
          , category = 2
          }
        ]
    }


type alias Model =
    { expenseTransactions : List ExpenseTransaction
    , incomeTransactions : List IncomeTransaction
    }


type alias ExpenseTransaction =
    { date : Date
    , amount : Float
    , description : String
    , category : Int
    }


type alias IncomeTransaction =
    { date : Date
    , amount : Float
    , description : String
    , category : Int
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
    tr []
        [ td [] [ text (renderDate transaction.date) ]
        , td [] [ text (toString transaction.amount) ]
        , td [] [ text transaction.description ]
        , td [] [ text (toString transaction.category) ]
        ]


renderExpensesTable : List ExpenseTransaction -> Html msg
renderExpensesTable rows =
    let
        renderedRows =
            List.map renderExpenseRow rows
    in
        table [] renderedRows


view : Model -> Html msg
view model =
    div [ class "container" ]
        [ h1 [] [ text "Cycad" ]
        , renderExpensesTable model.expenseTransactions
        ]
