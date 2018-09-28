module Main exposing (..)

--import Html.Events exposing (onClick)

import Browser
import Html exposing (Html, button, div, video)
import Html.Attributes exposing (controls, id, src)
import Media.Primitives exposing (Error(..), pause)
import Task


type Msg
    = NoOp
    | Pause
    | ControlResponse (Result Error ())


type alias Model =
    Bool


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        Pause ->
            ( False, Task.attempt ControlResponse (pause "test") )

        ControlResponse result ->
            ( model, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ video [ id "test", src "https://github.com/mediaelement/mediaelement-files/blob/master/big_buck_bunny.mp4?raw=true", controls True ] []
        ]


init : () -> ( Model, Cmd Msg )
init _ =
    ( True, Cmd.none )


main =
    Browser.element
        { init = init
        , subscriptions = always Sub.none
        , view = view
        , update = update
        }
