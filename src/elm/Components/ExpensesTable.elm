module Components.ExpensesTable exposing (..)

import Model exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Components.RenderDate exposing (renderDate)
import Components.ExpenseTransaction exposing (ExpenseTransaction, ExpensesForOneDay)
import Dict exposing (..)


renderExpenseRow : Model -> ExpenseTransaction -> Html msg
renderExpenseRow model transaction =
    div [ class "expense-day__row" ]
        [ div [ class "expense-day__row__amt" ] [ text (toString transaction.amount) ]
        , div [ class "expense-day__row__cat" ] [ text (toString (Dict.get transaction.category model.expenseCategories)) ]
        , div [ class "expense-day__row__desc" ] [ text transaction.description ]
        ]


renderExpensesForOneDay : Model -> ExpensesForOneDay -> Html msg
renderExpensesForOneDay model day =
    let
        oneDayOfTransactions =
            List.map (renderExpenseRow model) day.transactions
    in
        div [ class "expense-day" ]
            [ div [ class "expense-day__date" ] [ text (renderDate day.date) ]
            , div [ class "expense-day__transactions" ]
                oneDayOfTransactions
            ]


renderExpensesTable : Model -> Html msg
renderExpensesTable model =
    let
        renderedDays =
            List.map (renderExpensesForOneDay model) model.expenseTransactions
    in
        div [ class "expenses-table__container" ]
            [ h1 [ class "expenses-table__header" ] [ text "Expenses" ]
            , div [ class "expenses-table" ] renderedDays
            ]
