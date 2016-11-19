module Components.Sidebar exposing (renderSidebar)

import Model exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)


renderSidebar : Model -> Html msg
renderSidebar model =
    div [ class "sidebar__container" ]
        [ renderSidebarSection "Transactions" "/" True
        , renderSidebarSection "Overview" "/" False
        , renderSidebarSection "Budget" "/" False
        ]


type alias Title =
    String


type alias Link =
    String


type alias Selected =
    Bool


renderSidebarSection : Title -> Link -> Selected -> Html msg
renderSidebarSection title link selected =
    div [ class "sidebar__section" ]
        [ a [ class <| "sidebar__section__link" ++ applySelectedClass selected, renderLink link selected ]
            [ span [ class "sidebar__section__title" ] [ text title ]
            ]
        ]


applySelectedClass : Bool -> String
applySelectedClass selected =
    if selected == True then
        " -selected"
    else
        ""


renderLink : Link -> Selected -> Attribute msg
renderLink link selected =
    if selected == True then
        -- TODO: bad practice below. Find a good way to render nothing here
        id ""
    else
        href link
