module View exposing (view)

import Html exposing (Html)

import Model exposing (..)
import Subscription exposing (..)


view : Model -> Html Msg
view model =
  Svg.svg svgAttributes []


svgAttributes : List (Attribute Msg)
svgAttributes =
  [ width 50
  , height 50
  , viewBox <| "0 0 50 50"
  , property "xmlns:xlink" (Json.string "http://www.w3.org/1999/xlink")
  , version "1.1"
  , style "position: absolute; top: 0; left: 0;"
  ]
