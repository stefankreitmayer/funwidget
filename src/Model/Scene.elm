module Model.Scene exposing (..)

import Model.Shared exposing (..)


type alias Scene =
  { t : Float
  , points : List Point }

type alias Point = (Float,Float)


initialScene : Scene
initialScene =
  { t = 0
  , points = initialPoints }

initialPoints : List Point
initialPoints =
  []
