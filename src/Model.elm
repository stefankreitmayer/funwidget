module Model exposing (..)

import Model.Shared exposing (..)
import Model.Ui exposing (..)
import Model.Scene exposing (..)


type alias Model =
  { ui : UIState
  , scene : Scene }


initialModel : Model
initialModel =
  { ui = initialUi
  , scene = initialScene }
