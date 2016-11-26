module Modules.CompareEntries exposing (compareEntries)

import Date exposing (..)
import Modules.Transaction exposing (..)


compareEntries : ( Date, List Transaction ) -> ( Date, List Transaction ) -> Order
compareEntries ( date1, a ) ( date2, b ) =
    compare (toTime date1) (toTime date2)
