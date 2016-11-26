module Modules.Map exposing (Map)


type alias Map key val =
    { compare : ( key, val ) -> ( key, val ) -> Order
    , entries : List ( key, val )
    }
