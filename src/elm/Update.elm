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
            let
                currentMap =
                    model.allTransactions
            in
                ( { model | allTransactions = deleteRowFromTransactions id currentMap }, Cmd.none )

        AddTransaction ( date, trans ) ->
            let
                currentMap =
                    model.allTransactions
            in
                ( { model | allTransactions = addTransaction ( date, trans ) currentMap }, Cmd.none )


deleteRowFromTransactions : Int -> Map Date Transactions -> Map Date Transactions
deleteRowFromTransactions id map =
    let
        newEntries =
            List.map (deleteRowFromDay id) map.entries
    in
        { map | entries = newEntries }


deleteRowFromDay : Int -> TransactionsForOneDay -> TransactionsForOneDay
deleteRowFromDay id ( date, transactions ) =
    let
        newTransactions =
            List.filter (\el -> el.id /= id) transactions
    in
        ( date, newTransactions )


compareEntries : ( Date, List Transaction ) -> ( Date, List Transaction ) -> Order
compareEntries ( date1, a ) ( date2, b ) =
    compare (toTime date1) (toTime date2)


getFirstPart : ( List a, List b ) -> List a
getFirstPart ( listA, listB ) =
    listA


addTransaction : ( Date, Transaction ) -> Map Date Transactions -> Map Date Transactions
addTransaction ( date, newTransaction ) map =
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
            { map | entries = List.sortWith compare (( date, [ newTransaction ] ) :: otherEntries) }



-- map


addRowToDate : ( Date, Transaction ) -> List ( Date, List Transaction ) -> List ( Date, List Transaction )
addRowToDate dateAndTransaction entries =
    List.map (addIfCorrectDate dateAndTransaction) entries


addIfCorrectDate : ( Date, Transaction ) -> ( Date, List Transaction ) -> ( Date, List Transaction )
addIfCorrectDate ( date, transaction ) ( otherDate, list ) =
    if date == otherDate then
        ( otherDate, List.append list [ transaction ] )
    else
        ( otherDate, list )
