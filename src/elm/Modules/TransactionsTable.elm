module Modules.TransactionsTable exposing (..)

import Model exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Dict exposing (..)
import Modules.Helpers exposing (renderDate, renderAmount, formatAsMoney, applyColor)
import Modules.Transaction exposing (..)
import Html.Events exposing (onClick)
import Msg exposing (..)


categoryName : Maybe String -> String
categoryName category =
    case category of
        Just category ->
            category

        Nothing ->
            ""


renderTransactionRow : Model -> Transaction -> Html Msg
renderTransactionRow model transaction =
    div [ class "transactions-table__day__row", attribute "data-id" (toString transaction.id) ]
        [ div [ class "transactions-table__day__row__cat" ] [ text (categoryName (Dict.get transaction.category model.categories)) ]
        , div [ class ("transactions-table__day__row__amt" ++ applyColor transaction.amount) ] [ renderAmount transaction.amount ]
        , div [ class "transactions-table__day__row__desc" ] [ text transaction.description ]
        , a [ class "transactions-table__day__row__delete-link", onClick (DeleteTransaction transaction.id) ] [ text "x" ]
        ]


renderTransactionsForOneDay : Model -> TransactionsForOneDay -> Html Msg
renderTransactionsForOneDay model ( date, transactions ) =
    let
        oneDayOfTransactions =
            List.map (renderTransactionRow model) transactions
    in
        if List.isEmpty transactions == True then
            text ""
        else
            div [ class "transactions-table__day" ]
                [ div [ class "transactions-table__day__date" ] [ text (renderDate date) ]
                , div [ class "transactions-table__day__transactions" ]
                    oneDayOfTransactions
                ]


renderTransactionsTable : Model -> Html Msg
renderTransactionsTable model =
    let
        renderedDays =
            List.map (renderTransactionsForOneDay model) model.allTransactions.entries
    in
        div [ class "transactions-table__container" ]
            [ div [ class "transactions-table" ] renderedDays ]
