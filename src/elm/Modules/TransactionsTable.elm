module Modules.TransactionsTable exposing (..)

import Model exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Dict exposing (..)
import Modules.Helpers exposing (renderDate, renderAmount, formatAsMoney, applyColor)
import Modules.Transaction exposing (..)


categoryName : Maybe String -> String
categoryName category =
    case category of
        Just category ->
            category

        Nothing ->
            ""


renderTransactionRow : Model -> Transaction -> Html msg
renderTransactionRow model transaction =
    div [ class "transactions-table__day__row" ]
        [ div [ class "transactions-table__day__row__cat" ] [ text (categoryName (Dict.get transaction.category model.categories)) ]
        , div [ class ("transactions-table__day__row__amt" ++ applyColor transaction.amount) ] [ renderAmount transaction.amount ]
        , div [ class "transactions-table__day__row__desc" ] [ text transaction.description ]
        ]


renderTransactionsForOneDay : Model -> TransactionsForOneDay -> Html msg
renderTransactionsForOneDay model ( date, transactions ) =
    let
        oneDayOfTransactions =
            List.map (renderTransactionRow model) transactions
    in
        div [ class "transactions-table__day" ]
            [ div [ class "transactions-table__day__date" ] [ text (renderDate date) ]
            , div [ class "transactions-table__day__transactions" ]
                oneDayOfTransactions
            ]


renderTransactionsTable : Model -> Html msg
renderTransactionsTable model =
    let
        renderedDays =
            List.map (renderTransactionsForOneDay model) model.allTransactions.entries
    in
        div [ class "transactions-table__container" ]
            [ div [ class "transactions-table" ] renderedDays ]
