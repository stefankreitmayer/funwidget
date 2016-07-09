module Subscription exposing (..)

import Html exposing (Html)
import Time exposing (Time, second, every)

import Model exposing (..)


type Msg = Tick Time

subscriptions : Model -> Sub Msg
subscriptions model =
  every (second/30) Tick
