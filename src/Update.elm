module Update exposing (..)

import Model exposing (..)
import Subscription exposing (..)


update : Msg -> Model -> (Model, Cmd Msg)
update action model =
  case action of
    Tick t ->
      let
        radius' = (sin (t/100))*10+12
        model' = { radius = radius' }
      in
        (model', Cmd.none)
