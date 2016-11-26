module Update exposing (update)

import Modules.Map exposing (..)
import Model exposing (..)
import Msg exposing (..)
import Modules.Transaction exposing (..)
import Date exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        DeleteTransaction id ->
            -- ( { model | transactions = deleteRowFromTransactions id model.transactions }, Cmd.none )
            ( model, Cmd.none )

        AddTransaction id date amt desc cat ->
            ( model, Cmd.none )



-- deleteRowFromTransactions : Int -> List TransactionsForOneDay -> List TransactionsForOneDay
-- deleteRowFromTransactions id transactions =
--     List.map (deleteRowFromDay id) transactions
--
--
-- deleteRowFromDay : Int -> TransactionsForOneDay -> TransactionsForOneDay
-- deleteRowFromDay id day =
--     { day | transactions = List.filter (\el -> el.id /= id) day.transactions }
-- addTransaction : Date -> Transaction -> List TransactionsForOneDay -> List TransactionsForOneDay
-- addTransaction date newTransaction allTransactions =
--     let
--         target =
--             List.filter (\d -> d.date == date) allTransactions
--
--         newTransactions =
--             target.transactions ++ newTransaction
--
--         newDay =
--             { target | transactions = newTransactions }
--     in
--         allTransactions
--
--
-- insertEntry : ( key, val ) -> Map key val -> Map key val
--
--
-- insert newItem map =
--     let
--         compare =
--             map.compare
--
--         otherEntries =
--             map.entries
--     in
--         { map | entries = List.sortWith compare (newItem :: otherEntries) }
-- { allTransactions | target.transactions = target.transactions ++ newTransaction}


compareEntries : ( Date, List Transaction ) -> ( Date, List Transaction ) -> Order
compareEntries ( date1, a ) ( date2, b ) =
    compare (toTime date1) (toTime date2)


getFirstPart : ( List a, List b ) -> List a
getFirstPart ( listA, listB ) =
    listA


insert : ( Date, Transaction ) -> Map Date Transactions -> Map Date Transactions
insert ( date, newTransaction ) map =
    let
        dateAndTransaction =
            ( date, newTransaction )

        compare =
            map.compare

        otherEntries =
            map.entries

        existingDates =
            getFirstPart (List.unzip otherEntries)
    in
        if List.member date existingDates then
            { map | entries = addRowToDate dateAndTransaction otherEntries }
        else
            -- { map | entries = List.sortWith compare (dateAndTransaction :: otherEntries) }
            map


addRowToDate : ( Date, Transaction ) -> List ( Date, List Transaction ) -> List ( Date, List Transaction )
addRowToDate dateAndTransaction entries =
    List.map (addIfCorrectDate dateAndTransaction) entries


addIfCorrectDate : ( Date, Transaction ) -> ( Date, List Transaction ) -> ( Date, List Transaction )
addIfCorrectDate ( date, transaction ) ( otherDate, list ) =
    if date == otherDate then
        ( otherDate, List.append list [ transaction ] )
    else
        ( otherDate, list )
