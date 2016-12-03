module Update exposing (update)

import Modules.Map exposing (..)
import Model exposing (..)
import Msg exposing (..)
import Modules.Transaction exposing (..)
import Modules.DateAsInt exposing (..)
import Random.Pcg exposing (Seed, initialSeed, step)
import Uuid.Barebones exposing (uuidStringGenerator, isValidUuid)


-- every call to generate a new Uuid will give you a tuple of a Uuid and a new seed. It is very important that whenever you generate a new Uuid you store this seed you get back into your model and use this one for the next Uuid generation. If you reuse a seed, you will create the same Uuid twice!


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
            model ! []

        NewUuid ->
            let
                ( newUuid, newSeed ) =
                    step Uuid.Barebones.uuidStringGenerator model.currentSeed
            in
                { model
                    | currentUuid = newUuid
                    , currentSeed = newSeed
                }
                    ! []

        UpdateCapturedDate strDate ->
            { model | capturedDate = readAsInt strDate } ! []

        UpdateCapturedAmt strAmt ->
            { model | capturedAmt = String.toFloat strAmt |> Result.withDefault 0 } ! []

        UpdateCapturedDesc strDesc ->
            { model | capturedDesc = strDesc } ! []

        UpdateCapturedCat strCat ->
            { model | capturedCat = String.toInt strCat |> Result.withDefault 0 } ! []

        DeleteTransaction id ->
            let
                currentMap =
                    model.allTransactions
            in
                { model | allTransactions = deleteRowFromTransactions id currentMap } ! []

        AddTransaction ( date, amt, cat, desc ) ->
            let
                currentMap =
                    model.allTransactions

                newModel =
                    { model | allTransactions = addTransaction ( date, { id = model.currentUuid, amount = amt, category = cat, description = desc } ) currentMap }
            in
                update NewUuid newModel


deleteRowFromTransactions : String -> Map DateAsInt Transactions -> Map DateAsInt Transactions
deleteRowFromTransactions id map =
    let
        newEntries =
            List.map (deleteRowFromDay id) map.entries
    in
        { map | entries = newEntries }


deleteRowFromDay : String -> TransactionsForOneDay -> TransactionsForOneDay
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
