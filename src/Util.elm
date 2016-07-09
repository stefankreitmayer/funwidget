module Util exposing (..)

pi = 3.1415926536

-- Curves take [0..1] and give [0..1]

sCurve : Float -> Float
sCurve x =
  ((x - 0.5) * pi |> sin) / 2 + 0.5

nCurve : Float -> Float
nCurve x =
  x + (x - (sCurve x))*2

humpCurve : Float -> Float
humpCurve x =
  x * pi |> sin


interpolate : Float -> Float -> Float -> Float
interpolate a b p =
  a + (b-a) * p
