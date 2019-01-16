module Media.Primitives exposing
    ( Error(..)
    , getCurrentState
    , pause
    , play
    , seek
    , timeRangeDecoder
    )

import Debug
import Html
import Json.Decode exposing (Decoder)
import Json.Encode as Json
import Media.Types as Types
import Task exposing (Task)



{- The goal of this module is to provide the basic functions, decoders, and access to properties that require low-level Elm/Kernel code to
   allow seamless interaction with the browser's built-in media playback capabilities.

   The goal for now is to include these primitives in a larger package that can provide a really nice API for creating Audio and Video players in Elm,
   that work well and are easy to maintain, even with the overwhelming number of edge cases that working with media require.

   These primitives currently only cover the portions of the Media API that exist in the DOM spec. It definitely is my goal to eventually cover the four later media APIs in the Web API: Media Source Fragments, Media Source Extensions, Media Stream, and Web Audio. In fact, Media Source Fragments can be written in pure Elm and is already available. These represent more research and thoughtful API design effort, but I am excited about the possibilities Elm represents with regard to each of these.

      ###Playback Control

      @docs Error, play, pause, seek

      ###State

      @docs textTrackMode, getCurrentState, TimeRanges, timeRangeDecoder

-}


{-| An Error type representing the errors that the tasks in this library may encounter:

NotFound String : Many functions in this module lookup media elements by "id" (which is why it's so important to use unique id's for every media element). This error signifies that no element with that id was found (the string is reminder of the id).

NotMediaElement : Similar to NotFound, above, this error means the browser find an element with that id, but the element found wasn't an HTMLMediaElement (HTMLAudioElement or HTMLVideoElement)

PlayPromiseFailure : On most modern browsers, the HTMLMediaElement.play() function returns a promise. If the media doesn't play successfully, the promise with throw an error, and in Elm, you'll get this error message, with two strings representing the "id" of the element and a description of why playback did not begin. Pay close attention to these error descriptions, different browsers have different policies about when you can and can't begin playing media (particulary if that media has an audio track that isn't muted). For now, these primitives will get us very close to what media looked like when HTML5 first debuted earlier this decade.

-}
type Error
    = NotFound String
    | NotMediaElement String
    | PlayPromiseFailure String String


{-| Takes a string representing the unique id of the media element, and attempts to begin playback.
-}
play : Types.Id -> Task Error ()
play id =
    Debug.todo "Implement Play Task. Make sure to check if play returns promise, and if that promise is successful"


{-| Takes a string representing the unique id of the media element, and pauses playback.
-}
pause : Types.Id -> Task Error ()
pause id =
    Debug.todo "Implement Pause Task"


{-| (Seeking means moving the playhead of the current media player to a specific time) Takes a string representing the unique id of the media element, and a float representing the time you'd like to seek to, and attempts to seek to that time.
-}
seek : Types.Id -> Float -> Task Error ()
seek id time =
    Debug.todo "Implement Seek Task"


{-| Sets the mode of an HTMLTrack element. (equivalent to setting the track.mode property on the element. This is to keep this attribute descriptive as the rest of the text track element is. It's only necessary here as a quirk of the api and VirtualDom (it's a readwrite propert that's a subcomponent of a read-only property).
-}
textTrackMode : Types.TextTrackMode -> Html.Attribute msg
textTrackMode mode =
    Debug.todo "Implement textTrackMode"


{-| A task for getting the current state of the Media object. You could, for instance, subscribe to a Time subscription and call this task everytime the clock ticked, to make sure your state was accurate to within a second. Or you could call it when the various Media Events are called.
-}
getCurrentState : Types.Id -> Task Error Types.State
getCurrentState id =
    Debug.todo "implement getState"
