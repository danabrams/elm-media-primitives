module Media.Types exposing (..)


type alias State =
    { id : Id
    , mediaType : MediaType
    , playbackStatus : PlaybackStatus
    , readyState : ReadyState
    , source : String
    , currentTime : Float
    , duration : Float
    , networkState : NetworkState
    , buffered : List TimeRange
    , seekable : List TimeRange
    , played : List TimeRange
    , textTracks : List TextTrack
    }


type alias Id =
    String


type MediaType
    = Audio
    | Video { width : Int, height : Int }


type PlaybackStatus
    = Paused
    | Playing
    | Loading
    | Buffering
    | Ended
    | PlaybackError PlaybackError


type PlaybackError
    = Aborted String
    | Network String
    | Decode String
    | Unsupported String


type ReadyState
    = HaveNothing
    | HaveMetadata
    | HaveCurrentData
    | HaveFutureData
    | HaveEnoughData


type NetworkState
    = Empty
    | Idle
    | DataLoading
    | NoSource


type alias TimeRange =
    { start : Float
    , end : Float
    }


type TextTrackKind
    = Captions
    | Chapters
    | Descriptions
    | Metadata
    | Subtitles
    | Other String
    | None


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


type TextTrackMode
    = Disabled
    | Hidden
    | Showing


type alias VTTCue =
    { text : String
    , startTime : Float
    , endTime : Float
    }
