module Update exposing (update)

import Modules.Map exposing (..)
import Model exposing (..)
import Msg exposing (..)
import Modules.Transaction exposing (..)
import Date exposing (..)
import Modules.DateAsInt exposing (..)
import Modules.CompareEntries exposing (..)
import Random exposing (..)


readAsInt : String -> Int
readAsInt input =
    case String.toInt input of
        Err msg ->
            0

        Ok val ->
            val


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        GenerateRandomNumber ->
            ( model, Random.generate SetSeed (Random.int 1 9007199254740992) )

        SetSeed newRand ->
            ( { model | currentSeed = newRand }, Cmd.none )

        UpdateCapturedDate strDate ->
            ( { model | capturedDate = readAsInt strDate }, Cmd.none )

        UpdateCapturedAmt strAmt ->
            ( { model | capturedAmt = String.toFloat strAmt |> Result.withDefault 0 }, Cmd.none )

        UpdateCapturedDesc strDesc ->
            ( { model | capturedDesc = strDesc }, Cmd.none )

        UpdateCapturedCat strCat ->
            ( { model | capturedCat = String.toInt strCat |> Result.withDefault 0 }, Cmd.none )

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


deleteRowFromTransactions : Int -> Map DateAsInt Transactions -> Map DateAsInt Transactions
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



-- compareEntries : ( DateAsInt, List Transaction ) -> ( DateAsInt, List Transaction ) -> Order
-- compareEntries ( date1, a ) ( date2, b ) =
--     compare (toTime date1) (toTime date2)


getFirstPart : ( List a, List b ) -> List a
getFirstPart ( listA, listB ) =
    listA


addTransaction : ( DateAsInt, Transaction ) -> Map DateAsInt Transactions -> Map DateAsInt Transactions
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


addRowToDate : ( DateAsInt, Transaction ) -> List ( DateAsInt, List Transaction ) -> List ( DateAsInt, List Transaction )
addRowToDate dateAndTransaction entries =
    List.map (addIfCorrectDate dateAndTransaction) entries


addIfCorrectDate : ( DateAsInt, Transaction ) -> ( DateAsInt, List Transaction ) -> ( DateAsInt, List Transaction )
addIfCorrectDate ( date, transaction ) ( otherDate, list ) =
    if date == otherDate then
        ( otherDate, List.append list [ transaction ] )
    else
        ( otherDate, list )
