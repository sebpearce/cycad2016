port module Update exposing (update)

import Modules.Map exposing (..)
import Model exposing (..)
import Msg exposing (..)
import Dict
import Http exposing (..)
import Json.Encode
import Json.Decode exposing (list, string)
import Modules.Transaction exposing (..)
import Modules.DateAsInt exposing (..)
import Random.Pcg exposing (Seed, initialSeed, step)
import Uuid.Barebones exposing (uuidStringGenerator, isValidUuid)
import Config
import Dom
import Task


type alias SaveFormat =
    { entries : List TransactionsForOneDay
    , categories : List ( Int, String )
    }


port setStorage : SaveFormat -> Cmd msg


port selectOnClick : String -> Cmd msg


readAsInt : String -> Int
readAsInt input =
    case String.toInt input of
        Err msg ->
            0

        Ok val ->
            val


convertStringToMaybe : String -> Maybe String
convertStringToMaybe str =
    Just str


handleDescription : Maybe String -> String
handleDescription s =
    case s of
        Just s ->
            s

        Nothing ->
            ""


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        Save ->
            let
                appState =
                    { entries = model.allTransactions.entries
                    , categories = Dict.toList model.categories
                    }
            in
                ( model, setStorage appState )

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
            { model | capturedDesc = convertStringToMaybe strDesc } ! []

        -- UpdateCapturedCat strCat ->
        --     { model | capturedCat = String.toInt strCat |> Result.withDefault 0 } ! []
        UpdateCategorySearch input ->
            { model | capturedCatSearchInput = input } ! []

        UpdateCapturedCatId id ->
            { model | capturedCatId = id } ! []

        ClickedCategoryOption id name ->
            ( { model | capturedCatSearchInput = name, capturedCatId = id }, Cmd.none )

        -- ClickedCategoryOption id name ->
        --     ( { model | capturedCatSearchInput = name, capturedCatId = id }, (Dom.focus "capture__amount-picker__input") )
        -- FocusOnElement id ->
        --     ( model, Dom.focus id )
        DeleteTransaction id ->
            let
                currentMap =
                    model.allTransactions

                newModel =
                    { model | allTransactions = deleteRowFromTransactions id currentMap }

                path =
                    Config.serverPath ++ Config.deleteTransPath
            in
                ( newModel, deleteRowFromDB id path )

        TransactionDeleted (Ok response) ->
            ( model, consoleLog <| Json.Encode.string <| toString response )

        TransactionDeleted (Err error) ->
            ( model, consoleLog <| Json.Encode.string <| toString error )

        AddTransaction ( date, amt, cat, desc ) ->
            let
                currentMap =
                    model.allTransactions

                id =
                    model.currentUuid

                newModel =
                    { model | allTransactions = addTransaction ( date, { id = id, amount = amt, category_id = cat, description = desc } ) currentMap }

                ( newModelWithNewUuid, cmds ) =
                    update NewUuid newModel

                transactionToSave =
                    { id = id
                    , amount = amt
                    , date = date
                    , description = handleDescription desc
                    , category_id = cat
                    }

                path =
                    Config.serverPath ++ Config.addTransPath
            in
                ( newModelWithNewUuid, persistRow transactionToSave path )

        TransactionPersisted (Ok response) ->
            ( model, consoleLog <| Json.Encode.string <| toString response )

        TransactionPersisted (Err error) ->
            ( model, consoleLog <| Json.Encode.string <| toString error )

        CategoryInputKeyDown key ->
            if key == 13 then
                ( model, Cmd.none )
            else
                ( model, Cmd.none )

        SelectOnClick elementId ->
            ( model, selectOnClick elementId )


persistRow : TransactionWithDate -> String -> Cmd Msg
persistRow twd path =
    let
        payload =
            Json.Encode.object
                [ ( "id", Json.Encode.string twd.id )
                , ( "amount", Json.Encode.float twd.amount )
                , ( "date", Json.Encode.int twd.date )
                , ( "description", Json.Encode.string twd.description )
                , ( "category_id", Json.Encode.int twd.category_id )
                ]

        request =
            (Http.post path (Http.jsonBody payload) (Json.Decode.succeed "OK"))
    in
        Http.send TransactionPersisted request


deleteRowFromDB : TransactionId -> String -> Cmd Msg
deleteRowFromDB id path =
    let
        payload =
            Json.Encode.object [ ( "id", Json.Encode.string id ) ]

        request =
            (Http.post path (Http.jsonBody payload) (Json.Decode.succeed "OK"))
    in
        Http.send TransactionDeleted request


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


port consoleLog : Json.Encode.Value -> Cmd msg


port persistNewTransaction : TransactionWithDate -> Cmd msg


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
