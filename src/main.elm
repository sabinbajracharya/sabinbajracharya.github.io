module Main exposing (Model, Msg(..), init, main, subscriptions, update, view)

-- import Css exposing (..)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Svg as SVG
import Svg.Attributes as SvgAttr
import Task
import Time
import Url
import UserInfo



-- MAIN


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }


type alias Model =
    { key : Nav.Key
    , url : Url.Url
    , user : UserInfo.Model
    }


init : flags -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( Model key url UserInfo.init
    , Cmd.map GotUserInfo UserInfo.getUserInfo
    )



-- UPDATE

type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | GotUserInfo UserInfo.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            ( { model | url = url }
            , Cmd.none
            )

        GotUserInfo subMsg ->
            let
                ( newUserState, _ ) = UserInfo.update subMsg
            in
            ( { model | user = newUserState  }
            , Cmd.none
            )


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Browser.Document Msg
view model =
    { title = "Sabin | Blog"
    , body =
        [ div [ class "section" ]
            [ div [ class "container is-desktop" ]
                [ div [ class "columns" ]
                    [ div [ class "column" ] [ (Html.map GotUserInfo) (UserInfo.view model.user) ]
                    , div [ class "is-hidden-mobile has-background-white-bis has-text-white", style "width" "2px" ] []
                    , div [ class "column is-two-thirds" ] [ content ]
                    ]
                ]
            ]
        ]
    }


-- Content


content : Html Msg
content =
    div [ class "section" ]
        [ div [ class "container" ]
            [ post
            , post
            ]
        ]


post : Html Msg
post =
    div [ class "column" ]
        [ div []
            [ span [ class "has-text-black" ] [ text "June 2019" ]
            , span [ style "margin" "0px 0.3125rem" ] []
            , span [ style "color" "#f7a046" ] [ text "FUN WITH ARRAYS" ]
            ]
        , h3 [ class "title is-3" ] [ text "Fun With forEach" ]
        , p []
            [ text "Have fun with forEach by guessing few snippets that we might not encounter in real-time applications. Share your fun forEach snippets and let's all have fun! 👯\u{200D}♂️👯\u{200D}♂️" ]
        , space "margin-top" "16px"
        , a [ href "" ] [ text "Read" ]
        , space "margin-bottom" "32px"
        ]


space : String -> String -> Html Msg
space property value =
    div [ style property value ] []



--   css


pad_md =
    "8px"
