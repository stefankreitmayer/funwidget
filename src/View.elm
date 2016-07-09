module View exposing (view)

import Html exposing (Html)
import Svg exposing (Svg,Attribute)
import Svg.Attributes as Attributes exposing (..)
import Svg.Events exposing (onClick)
import Time exposing (Time)
import String
-- import Debug exposing (log)

import Util exposing (interpolate,sCurve,nCurve,humpCurve)

import Model exposing (..)
import Model.Shared exposing (..)
import Model.Ui exposing (..)
import Model.Scene exposing (..)
import Subscription exposing (..)

import VirtualDom exposing (property)
import Json.Encode as Json

view : Model -> Html Msg
view {ui,scene} =
  renderAll ui.windowSize scene

renderAll : (Int,Int) -> Scene -> Html.Html Msg
renderAll (w,h) ({t,points} as scene) =
  let
      windowSize = (w,h)
  in
     Svg.svg (svgAttributes windowSize)
     [ renderWaterSurface windowSize scene
     , renderContact windowSize
     ]

svgAttributes : (Int, Int) -> List (Attribute Msg)
svgAttributes (w, h) =
  [ width (toString w)
  , height (toString h)
  , viewBox <| "0 0 " ++ (toString w) ++ " " ++ (toString h)
  , property "xmlns:xlink" (Json.string "http://www.w3.org/1999/xlink")
  , version "1.1"
  , style "position: fixed;"
  ]


renderContact : (Int,Int) -> Svg Msg
renderContact (w,h) =
  let
      y = h-13
      x = w-13
  in
     Svg.g []
     [ renderTextLine x y "end" "E-mail"
     -- [ textDecoration "underline" ] |> mailto "stefan@kreitmayer.com"
     [] |> mailto "stefan@kreitmayer.com"
     ]

externalHyperlink : String -> Svg Msg -> Svg Msg
externalHyperlink url child =
  Svg.a
  [ xlinkHref url ]
  [
    child
  ]


mailto : String -> Svg Msg -> Svg Msg
mailto emailAddress child =
  Svg.a
  [ xlinkHref ("mailto:" ++ emailAddress) ]
  [
    child
  ]


renderTextParagraph : Int -> Int -> String -> List String -> List (Svg.Attribute Msg) -> Svg Msg
renderTextParagraph xPos yPos anchor lines extraAttrs =
  List.indexedMap (\index line -> renderTextLine xPos (yPos+index*normalLineHeight) anchor line extraAttrs) lines
  |> Svg.g []


renderTextLine : Int -> Int -> String -> String -> List (Svg.Attribute Msg) -> Svg Msg
renderTextLine xPos yPos anchor content extraAttrs =
  let
      attributes = [ x <| toString xPos
                   , y <| toString yPos
                   , fontSize <| toString normalFontSize
                   , textAnchor anchor
                   , fontFamily "Verdana,Helvetica,sans"
                   , fill "rgba(255,255,255,.6)"
                   , opacity "0.9"
                   ]
                   |> List.append extraAttrs
  in
      Svg.text' attributes [ Svg.text content ]


renderWaterSurface : (Int,Int) -> Scene -> Svg Msg
renderWaterSurface (w,h) {t,points} =
  points
  |> List.append (cornerPoints (w,h))
  |> polygon "rgba(0,190,255,.1)"


polygon : String -> List Point -> Svg Msg
polygon fillColor points =
      Svg.polygon
      [ Attributes.fill fillColor
      , Attributes.points (pointsToString points) ]
      []


cornerPoints : (Int,Int) -> List Point
cornerPoints (w,h) =
  let
      wf = (toFloat w)
      hf = (toFloat h)
  in
      [ (wf,hf), (0,hf) ]


pointsToString : List Point -> String
pointsToString points =
  points
  |> List.map (\(x,y) -> (toString x)++","++(toString y))
  |> String.join " "


renderCircle : Time -> Point -> Float -> Svg Msg
renderCircle t (x,y) r =
  Svg.circle
  [ cx <| toString x
  , cy <| toString y
  , Attributes.r <| toString r
  , fill "blue"
  ]
  []

normalFontSize : Int
normalFontSize = 16

normalLineHeight : Int
normalLineHeight =
  (toFloat normalFontSize) * 1.38 |> floor
