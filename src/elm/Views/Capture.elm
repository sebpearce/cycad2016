module Views.Capture exposing (..)

import Model exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Msg exposing (..)
import Dict
import Html.Events exposing (onInput)
import Modules.OnKeyDown exposing (onKeyDown)


-- import Modules.Helpers exposing (renderDate, renderAmount, formatAsMoney, applyColor)
-- import Modules.Transaction exposing (..)


renderCapture : Model -> Html Msg
renderCapture model =
    div [ class "capture-overlay" ]
        [ div [ class "capture-container" ]
            [ div [ class "capture" ]
                [ div [ class "capture__tips" ] [ text "[ and  ] to change day,  { and } to change week" ]
                , div [ class "capture__date-display" ] [ text "Wednesday, 17 September 2016" ]
                , div [ class "capture__date-picker" ]
                    [ div [ class "capture__date-picker__cell" ] [ text "M" ]
                    , div [ class "capture__date-picker__cell" ] [ text "T" ]
                    , div [ class "capture__date-picker__cell -active" ] [ text "W" ]
                    , div [ class "capture__date-picker__cell" ] [ text "T" ]
                    , div [ class "capture__date-picker__cell" ] [ text "F" ]
                    , div [ class "capture__date-picker__cell" ] [ text "S" ]
                    , div [ class "capture__date-picker__cell" ] [ text "S" ]
                    ]
                , div [ class "capture__pickers-container" ]
                    [ div [ class "capture__category-picker" ]
                        [ div [ class "capture__category-picker__label" ] [ text "Category" ]
                        , input [ autofocus True, tabindex 1, class "capture__category-picker__input", onInput UpdateCategorySearch, onKeyDown CategoryInputKeyDown ] []
                        ]
                    , div [ class "capture__amount-picker" ]
                        [ div [ class "capture__amount-picker__label" ] [ text "Amount" ]
                        , input [ tabindex 2, class "capture__amount-picker__input", value "17.99" ] []
                        ]
                    ]
                , renderCaptureOptions model
                ]
            ]
        ]


renderCaptureOptions : Model -> Html Msg
renderCaptureOptions model =
    let
        categories =
            List.map (\( _, cat ) -> cat) (Dict.toList model.categories)

        filteredCategories =
            getMatchingCategories categories model.capturedCatSearchInput

        items =
            List.map renderCaptureOptionsItem filteredCategories

        output =
            div [ class "capture__category-options" ] items
    in
        output


renderCaptureOptionsItem : String -> Html Msg
renderCaptureOptionsItem category =
    div [ class "capture__category-options__item" ] [ text category ]


getMatchingCategories : List String -> String -> List String
getMatchingCategories allCats pattern =
    List.filter (\c -> String.contains (String.toLower pattern) (String.toLower c) == True) allCats



-- categoryName : Maybe String -> String
-- categoryName category =
--     case category of
--         Just category ->
--             category
--
--         Nothing ->
--             ""
--
--
-- renderTransactionRow : Model -> Transaction -> Html Msg
-- renderTransactionRow model transaction =
--     div [ class "transactions-table__day__row", attribute "data-id" (toString transaction.id) ]
--         [ div [ class "transactions-table__day__row__cat" ] [ text (categoryName (Dict.get transaction.category_id model.categories)) ]
--         , div [ class ("transactions-table__day__row__amt" ++ applyColor transaction.amount) ] [ renderAmount transaction.amount ]
--         , div [ class "transactions-table__day__row__desc" ] [ text <| Maybe.withDefault "" transaction.description ]
--         , a [ class "transactions-table__day__row__delete-link", onClick (DeleteTransaction transaction.id) ] [ text "x" ]
--         ]
--
--
-- renderTransactionsForOneDay : Model -> TransactionsForOneDay -> Html Msg
-- renderTransactionsForOneDay model ( date, transactions ) =
--     let
--         oneDayOfTransactions =
--             List.map (renderTransactionRow model) transactions
--     in
--         if List.isEmpty transactions == True then
--             text ""
--         else
--             div [ class "transactions-table__day" ]
--                 [ div [ class "transactions-table__day__date" ] [ text (renderDate date) ]
--                 , div [ class "transactions-table__day__transactions" ]
--                     oneDayOfTransactions
--                 ]
--
--
-- renderTransactionsTable : Model -> Html Msg
-- renderTransactionsTable model =
--     let
--         renderedDays =
--             List.map (renderTransactionsForOneDay model) model.allTransactions.entries
--     in
--         div [ class "transactions-table__container" ]
--             [ div [ class "transactions-table" ] renderedDays ]
