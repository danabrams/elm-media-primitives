module Media.Types exposing (Id, MediaType(..), NetworkState(..), PlaybackError(..), PlaybackStatus(..), ReadyState(..), State, TextTrack, TextTrackKind(..), TextTrackMode(..), TimeRanges, VTTCue)

{-| large record representing the totality of the state of the media element. Most of these have custom types that will give more information. The field "source" represents the media source, which will probably a url for now, but could also be a blob, file or stream. "currentTime" is the current time of playback of the media. If you've been listening to a file for three minutes exactly (from the beginning without jumping around) it will be 180. "duration" is the current length of the media ("infinity" or "NaN" for livestreams, depending on the browser, so be careful, it's why the TimeRanges "seekable" is so important.
-}

{- The goal of this module is to provide the basic types used in the Media.Primitives module, to represent the state of a media element.

   @docs State, Id, MediaType, PlaybackStatus, TimeRanges, NetworkState, ReadyState, PlaybackError, TextTrack, TextTrackMode, TextTrackKind, VTTCue
-}


type alias State =
    { id : Id
    , mediaType : MediaType
    , playbackStatus : PlaybackStatus
    , readyState : ReadyState
    , source : String
    , currentTime : Float
    , duration : Float
    , networkState : NetworkState
    , buffered : TimeRanges
    , seekable : TimeRanges
    , played : TimeRanges
    , textTracks : List TextTrack
    }


{-| Just an alias for a string representing the Media Element's Id. document.getElementById() is an important function for using the media API, and in this library.
-}
type alias Id =
    String


{-| Is it audio or video, and if it's video, what are the dimensions. Necessary to query this sometimes, as audio and video players, while mostly the same, often look different.
-}
type MediaType
    = Audio
    | Video { width : Int, height : Int }


{-| Represents the current playback status of the element.

Here's what each means:
Paused - Playback is paused (or stopped, stopped is just a version of paused)
Playing - Media is successfully playing.
Loading - Media is loading, but doesn't yet have enough information to start playing(in contrast to buffering).
Buffering - There is some media content data, the media may even have been playing already, but there's not enough to keep going right now, so it's buffering, waiting for more data to laod.
Ended - Media successfully played through to the end.
PlaybackError - There was a problem. See below.

-}
type PlaybackStatus
    = Paused
    | Playing
    | Loading
    | Buffering
    | Ended
    | PlaybackError PlaybackError


{-| These represent the various errors that can keep a media file from playing.

Aborted - The user aborted playback
Network - There was a network issue that kept the file from loading or buffering
Decode - There was an issue decoding the file.
Unsupported - This media is unsupported by this browser.

-}
type PlaybackError
    = Aborted String
    | Network String
    | Decode String
    | Unsupported String


{-| Represents the current amount of data the browser has buffered of the media file.

HaveNothing - No data yet.
HaveMetadata - The metadata about the file, so things like dimensions and file type can be determined, but no buffers yet to play.
HaveCurrentData - The data up to this point (the current time in playback, but not enough data past this point to keep playing.
HaveFutureData - Some data has been buffered, and you can play if you want, but not enough to play successfully through to the end.
HaveEnoughData - Either all of the data remaining in the media file is buffered, or enough is buffered that at current bandwidth rates, the user can probably playback at normal speed and have it all buffered by the time they reach the end.

-}
type ReadyState
    = HaveNothing
    | HaveMetadata
    | HaveCurrentData
    | HaveFutureData
    | HaveEnoughData


{-| Media Elements (mostly) load their own files with their own http requests, this represents the current state of the network during download.
Empty - No data at all yet
Idle - Not currently downloading
DataLoading - Downloading
NoSource - Can't download because it doesn't have a source it can successfully download.
-}
type NetworkState
    = Empty
    | Idle
    | DataLoading
    | NoSource


{-| Time ranges are really important to some aspects of media playback. A file might not load linearly, or a user might skip around a video playing different sections, and you need lists of time ranges to keep track of what's been played.

For instance, if a user starts a video, watches 10 seconds, then jumps to 3 minutes in and watches 10 more seconds, the played TimeRange may look like this:
`[{start: 0.0, end: 10.19}, {start: 180.17, 190.22}]`

-}
type alias TimeRanges =
    List
        { start : Float
        , end : Float
        }


{-| Text Tracks, like subtitles, can be of many different kinds, and these are the ones laid out by the Media API spec

Captions - Usually represent dialogue and sound effects cues in text form for those who cannot hear the audio track.
Chapters - Represents chapter cues (such as on a DVD)
Descriptions - Textual description of the visual content of the video (such as a vision impaired user may read using a screen reader)
Metadata - Other data, typically for reading by software, not human eyes. Can be used for synchronization data or extra content.
Subtitles - Subtitles, in contrast to Captions, offer a textual translation of the spoken dialogue, but not other audible cues that aren't language specific. These are cues for speakers of a different language, not those with auditory disabilities.
None - No kind present

-}
type TextTrackKind
    = Captions
    | Chapters
    | Descriptions
    | Metadata
    | Subtitles
    | None


{-| Represents a text track, such as a subtitle or captions file. each track has an id, a list of active cues (active meaning that the current time is within their time range of visibility.
Also has a list of all cues, active or otherwise, and a TextTrackKind explaining what kind of cues are present on this track.
Also has a label for the name of this track (for instance, "English for the Hard of Hearing" for English-language captions), as well as a string representing the language of the titles, and a mode (Showing, Hidden, Disabled).
The inBandMetadataTrackDispachType is a string representing data, mostly from legacy broadcasts. You probably don't need it, and if you do, you already most likely know what it is.
-}
type alias TextTrack =
    { id : String
    , activeCues : List VTTCue
    , cues : List VTTCue
    , kind : TextTrackKind
    , inBandMetadataTrackDispatchType : String
    , label : String
    , language : String
    , mode : TextTrackMode
    }


{-| Represents the current state of a given Text Track.
Showing - the track's cues are visible on the media element, such as currently activated captions.
Disabled - the track's cues are invisible and never active. The application is just not using them currently.
Hidden - the track's cues are not visible, but may be active, and may trigger and event on change. These are useful for hidden metadata, like Chapters, that shouldn't be displayed on the media.
-}
type TextTrackMode
    = Disabled
    | Hidden
    | Showing


{-| Represents a given cue on a text track. Has an in and out point (startTime and endTime) and text (which can be language, or can be html, or can be markup, or metadata, or whatever you want).
-}
type alias VTTCue =
    { text : String
    , startTime : Float
    , endTime : Float
    }
