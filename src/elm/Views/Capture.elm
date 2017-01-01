module Views.Capture exposing (..)

import Model exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Msg exposing (..)
import Dict
import Html.Events exposing (onInput, onClick, onMouseOver)
import Modules.OnKeyDown exposing (onKeyDown)


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
                        , input [ autofocus True, tabindex 1, class "capture__category-picker__input", id "capture__category-picker__input", onInput UpdateCategorySearch, onKeyDown CategoryInputKeyDown, value model.capturedCatSearchInput ] []
                        ]
                    , div [ class "capture__amount-picker" ]
                        [ div [ class "capture__amount-picker__label" ] [ text "Amount" ]
                        , input [ tabindex 2, class "capture__amount-picker__input", id "capture__amount-picker__input", onInput UpdateCapturedAmt ] []
                        ]
                    ]
                , if model.capturedCatSearchInput /= "" then
                    renderCaptureOptions model
                  else
                    text ""
                ]
            ]
        ]


renderCaptureOptions : Model -> Html Msg
renderCaptureOptions model =
    let
        categories =
            Dict.toList model.categories

        filteredCategories =
            getMatchingCategories categories model.capturedCatSearchInput

        items =
            List.map renderCaptureOptionsItem filteredCategories

        output =
            div [ class "capture__category-options" ] items
    in
        output


renderCaptureOptionsItem : ( Int, String ) -> Html Msg
renderCaptureOptionsItem ( id, category ) =
    div [ class "capture__category-options__item", onMouseOver (UpdateCapturedCatId id), onClick (ClickedCategoryOption id category) ] [ text (category) ]


getMatchingCategories : List ( Int, String ) -> String -> List ( Int, String )
getMatchingCategories allCats pattern =
    List.filter (\( i, c ) -> String.contains (String.toLower pattern) (String.toLower c) == True) allCats
