import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Url
import Task
import Time



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



-- MODEL


type alias Model =
  { key : Nav.Key
  , url: Url.Url
  }


init : flags -> Url.Url -> Nav.Key -> (Model, Cmd Msg)
init flags url key =
  ( Model key url
  , Cmd.none
  )



-- UPDATE


type Msg
  = LinkClicked Browser.UrlRequest
  | UrlChanged Url.Url



update : Msg -> Model -> (Model, Cmd Msg)
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



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none



-- VIEW


view : Model -> Browser.Document Msg
view model =
  { title = "Sabin | Blog"
  , body =
    [ b [] [ text (Url.toString model.url) ]
    , viewLink "/Blog"
    , viewLink "/Projects"
    , viewLink "/Rants"
    , viewLink "/Talks"
    ]
  }

viewLink : String -> Html Msg
viewLink path =
  li [] [ a [ href path ] [ text path] ]