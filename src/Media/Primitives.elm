module Media.Primitives exposing (Error(..), pause)

import Elm.Kernel.MediaPrimitives exposing (load, pause, play, seek)
import Task


type Error
    = NotFound String
    | NotMediaElement String
    | PlayPromiseFailure String String



{-
   play : String -> Result Error ()
   play id =
       Native.play id

-}


pause : String -> Task.Task Error ()
pause =
    Elm.Kernel.MediaPrimitives.pause



{-
   load : String -> Result Error ()
   load id =
       Native.load


   seek : String -> Float -> Result Error ()
   seek id time =
       Native.seek id time
-}
