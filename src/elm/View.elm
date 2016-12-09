module View exposing (..)

import Model exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Msg exposing (..)
import Modules.TransactionsTable exposing (renderTransactionsTable)
import Modules.Sidebar exposing (renderSidebar)


view : Model -> Html Msg
view model =
    div [ class "main-container" ]
        [ renderSidebar model
        , div [ class "content__container" ]
            [ button
                [ onClick (DeleteTransaction "4") ]
                [ text "Delete!" ]
            , button
                [ onClick (AddTransaction ( model.capturedDate, model.capturedAmt, model.capturedCat, model.capturedDesc )) ]
                [ text "Add!" ]
            , input [ onInput UpdateCapturedDate ] []
            , input [ onInput UpdateCapturedAmt ] []
            , input [ onInput UpdateCapturedDesc ] []
            , input [ onInput UpdateCapturedCat ] []
            , button
                [ onClick NewUuid ]
                [ text "Generate!" ]
            , button
                [ onClick Save ]
                [ text "Test storage" ]
            , renderTransactionsTable model
            ]
        ]
