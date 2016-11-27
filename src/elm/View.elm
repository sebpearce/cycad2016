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
            [ renderTransactionsTable model
            , button
                [ onClick (DeleteTransaction 4) ]
                [ text "Delete!" ]
            ]
        ]
