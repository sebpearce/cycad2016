module Model exposing (..)

import Components.DictOfCategories exposing (DictOfCategories)
import Components.IncomeTransaction exposing (IncomeTransaction)
import Components.ExpenseTransaction exposing (ExpenseTransaction, ExpensesForOneDay)


type alias Model =
    { expenseTransactions : List ExpensesForOneDay
    , incomeTransactions : List IncomeTransaction
    , expenseCategories : DictOfCategories
    , incomeCategories : DictOfCategories
    }
