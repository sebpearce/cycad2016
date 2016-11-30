module View exposing (..)

import Model exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Msg exposing (..)
import Update exposing (..)
import Modules.TransactionsTable exposing (renderTransactionsTable)
import Modules.Sidebar exposing (renderSidebar)


view : Model -> Html Msg
view model =
    div [ class "main-container" ]
        [ renderSidebar model
        , div [ class "content__container" ]
            [ renderTransactionsTable model
            , button
                [ onClick (DeleteTransaction 4) ]
                [ text "Delete!" ]
            , button
                [ onClick (AddTransaction ( model.capturedDate, { id = 99, amount = model.capturedAmt, description = model.capturedDesc, category = model.capturedCat } )) ]
                [ text "Add!" ]
            , input [ onInput UpdateCapturedDate ] []
            , input [ onInput UpdateCapturedAmt ] []
            , input [ onInput UpdateCapturedDesc ] []
            , input [ onInput UpdateCapturedCat ] []
            , button
                [ onClick (GenerateRandomNumber) ]
                [ text "Generate!" ]
            ]
        ]
