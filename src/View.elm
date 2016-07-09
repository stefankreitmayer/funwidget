module View exposing (view)

import Html exposing (Html)
import Svg exposing (Svg,circle)
import Svg.Attributes exposing (style,version,viewBox,height,xHeight,width,cx,cy,r)

import Model exposing (..)
import Subscription exposing (..)

import Json.Encode as Json
import VirtualDom exposing (property)


view : Model -> Html Msg
view model =
  Svg.svg svgAttributes (svgChildren model.radius)


svgAttributes : List (Svg.Attribute Msg)
svgAttributes =
  [ width "50"
  , height "50"
  , viewBox <| "0 0 50 50"
  , property "xmlns:xlink" (Json.string "http://www.w3.org/1999/xlink")
  , version "1.1"
  , style "position: absolute; top: 0; left: 0;"
  ]

svgChildren : Float -> List (Svg Msg)
svgChildren radius =
  [
    renderCircle radius
  ]

renderCircle : Float -> Svg Msg
renderCircle radius =
  let
      radiusString = toString radius
  in
      circle [ cx "25", cy "25", r radiusString ] []
