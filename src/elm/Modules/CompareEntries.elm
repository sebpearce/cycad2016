module Modules.CompareEntries exposing (compareEntries)

import Modules.Transaction exposing (..)
import Modules.DateAsInt exposing (..)


compareEntries : ( DateAsInt, List Transaction ) -> ( DateAsInt, List Transaction ) -> Order
compareEntries ( date1, a ) ( date2, b ) =
    compare date1 date2



-- compareEntries ( date1, a ) ( date2, b ) =
--     compare (toTime date1) (toTime date2)
