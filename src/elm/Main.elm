module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App exposing (beginnerProgram)
import Date exposing (..)
import Dict exposing (..)


-- import Html.Events exposing (onInput)

import Model exposing (..)
import Components.TransactionsTable exposing (renderTransactionsTable)


-- MODEL


main : Program Never
main =
    beginnerProgram { model = initialModel, view = view, update = update }


initialModel : Model
initialModel =
    { transactions =
        [ { date = Date.fromString "2016/10/23" |> Result.withDefault (Date.fromTime 0)
          , transactions =
                [ { id = 1, amount = -17.54, description = "stuff", category = 3 }
                , { id = 2, amount = -15.0, description = "things", category = 1 }
                , { id = 3, amount = 636.0, description = "", category = 5 }
                ]
          }
        , { date = Date.fromString "2016/10/24" |> Result.withDefault (Date.fromTime 0)
          , transactions =
                [ { id = 4, amount = -10111.23, description = "stuff", category = 3 }
                , { id = 5, amount = -71.0, description = "things", category = 2 }
                , { id = 6, amount = 4000.0, description = "", category = 4 }
                , { id = 7, amount = -75.9, description = "", category = 2 }
                ]
          }
        ]
    , categories =
        Dict.fromList
            [ ( 1, "Rent" )
            , ( 2, "Groceries" )
            , ( 3, "Eating out" )
            , ( 4, "Salary" )
            , ( 5, "Partner's salary" )
            , ( 6, "Gifts" )
            ]
    }



-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model



-- VIEW


view : Model -> Html msg
view model =
    div [ class "main-container" ]
        [ renderTransactionsTable model ]
