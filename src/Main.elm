port module Main exposing (..)

import Browser
import Html exposing (Html)
import Html.Events as HE


type alias Model =
    { message : String, waitForReply : Bool }


type Msg
    = Alert
    | GotMessage String


type alias Flags =
    ()


port alert : String -> Cmd msg


port reply : (String -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions model =
    case model.waitForReply of
        True ->
            reply GotMessage

        False ->
            Sub.none


init : Flags -> ( Model, Cmd Msg )
init =
    always ( { message = "", waitForReply = False }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotMessage message ->
            ( { model | message = message, waitForReply = False }, Cmd.none )

        Alert ->
            ( { model | waitForReply = True }, alert "Alert Message" )


view : Model -> Html Msg
view model =
    Html.div []
        [ Html.span [] [ Html.text "this is elm app" ]
        , Html.div [] [ Html.button [ HE.onClick Alert ] [ Html.text "alert me" ] ]
        , Html.div [] [ Html.text model.message ]
        ]


main : Program Flags Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
