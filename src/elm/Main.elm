module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App exposing (program)
import Html.Events exposing (onClick, onInput)
import Model exposing (..)
import Modules.TransactionsTable exposing (renderTransactionsTable)
import Modules.Sidebar exposing (renderSidebar)
import Msg exposing (..)
import Update exposing (..)


-- MODEL


main : Program Never
main =
    program
        { init = init
        , view = view
        , update = Update.update
        , subscriptions = subscriptions
        }



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "main-container" ]
        [ renderSidebar model
        , div [ class "content__container" ]
            [ renderTransactionsTable model
            , button [ onClick (Delete 4) ] [ text "Delete!" ]
            ]
        ]
