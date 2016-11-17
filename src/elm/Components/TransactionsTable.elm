module Components.TransactionsTable exposing (..)

import Model exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Components.RenderDate exposing (renderDate)
import Components.Transaction exposing (Transaction, TransactionsForOneDay)
import Dict exposing (..)


renderTransactionRow : Model -> Transaction -> Html msg
renderTransactionRow model transaction =
    div [ class "transactions-table__day__row" ]
        [ div [ class "transactions-table__day__row__amt" ] [ text (toString transaction.amount) ]
        , div [ class "transactions-table__day__row__cat" ] [ text (toString (Dict.get transaction.category model.categories)) ]
        , div [ class "transactions-table__day__row__desc" ] [ text transaction.description ]
        ]


renderTransactionsForOneDay : Model -> TransactionsForOneDay -> Html msg
renderTransactionsForOneDay model day =
    let
        oneDayOfTransactions =
            List.map (renderTransactionRow model) day.transactions
    in
        div [ class "transactions-table__day" ]
            [ div [ class "transactions-table__day__date" ] [ text (renderDate day.date) ]
            , div [ class "transactions-table__day__transactions" ]
                oneDayOfTransactions
            ]


renderTransactionsTable : Model -> Html msg
renderTransactionsTable model =
    let
        renderedDays =
            List.map (renderTransactionsForOneDay model) model.transactions
    in
        div [ class "transactions-table__container" ]
            [ h1 [ class "transactions-table__header" ] [ text "Transactions" ]
            , div [ class "transactions-table" ] renderedDays
            ]
