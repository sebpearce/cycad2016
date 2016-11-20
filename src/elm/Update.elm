module Update exposing (update)

import Model exposing (..)
import Msg exposing (..)
import Modules.Transaction exposing (Transaction, TransactionsForOneDay)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        Delete id ->
            ( { model | transactions = deleteRowFromTransactions id model.transactions }, Cmd.none )


deleteRowFromTransactions : Int -> List TransactionsForOneDay -> List TransactionsForOneDay
deleteRowFromTransactions id transactions =
    List.map (deleteRowFromDay id) transactions


deleteRowFromDay : Int -> TransactionsForOneDay -> TransactionsForOneDay
deleteRowFromDay id day =
    { day | transactions = List.filter (\el -> el.id /= id) day.transactions }
