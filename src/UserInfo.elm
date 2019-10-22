
module UserInfo exposing
    ( getUserInfo
    , UserInfo
    , getUserInfoLocal
    , Msg
    , Model
    , view
    , update
    , init
    )

import Http
import Json.Decode exposing (Decoder, string, at, map3, decodeString, string, Error)
import Svg as SVG
import Svg.Attributes as SvgAttr
import Html exposing (..)
import Html.Attributes exposing (..)

type alias UserInfo =
    { name : String
    , bio : String
    , profile_pic_url : String
    }


type Model
  = Failure String
  | Loading
  | Success UserInfo


type Msg
  = GotUserInfo (Result Http.Error UserInfo)

init : Model
init =
    Loading

resUserInfo = """
{
    "name": "Sabin Bir Bajracharay"
,   "bio": "A fellow human 💕 Love building things over web | mobile | server... 💕 doing Dart, Kotlin, Rust and Node!!! Curated @elm 🐹🤖 with 🔥"
,   "profile_pic_url": "https://gokatz.me/photo.jpg"

}
"""

userinfoDecoder : Decoder UserInfo
userinfoDecoder =
    map3 UserInfo
        ( at ["name"] string )
        ( at ["bio"] string )
        ( at ["profile_pic_url"] string )


-- HTTP
getUserInfo : Cmd Msg
getUserInfo =
    Http.get
        { url = "https://us-central1-peronal-blog.cloudfunctions.net/api/user"
        , expect = Http.expectJson GotUserInfo userinfoDecoder
        }


getUserInfoLocal : Result Error UserInfo
getUserInfoLocal =
    decodeString userinfoDecoder resUserInfo


view : Model -> Html Msg
view model  =
    div [ class "section" ]
        [ div [ class "container" ] ( viewLeftNav model )
        ]


update : Msg -> ( Model, Cmd Msg )
update msg =
    case msg of
        GotUserInfo result ->
            case result of
                Ok userInfo ->
                    ( Success userInfo , Cmd.none )

                Err error ->
                    ( Failure ( Debug.toString error ) , Cmd.none )


viewLeftNav : Model -> List (Html Msg)
viewLeftNav model =
    case model of
        Loading ->
            []

        Success userInfo ->
            [ leftProfilePicColumn userInfo.profile_pic_url
            , leftProfileNameColumn userInfo.name
            , leftDescriptionColumn userInfo.bio
            , leftLinkColumn
            , leftContactColumn
            ]

        Failure msg ->
            [ div [] [ text msg ]
            ]


leftProfilePicColumn : String -> Html Msg
leftProfilePicColumn url =
    div [ class "column" ]
        [ figure [ class "image is-64x64" ]
            [ img [ class "is-rounded", src url ] []
            ]
        ]


leftProfileNameColumn : String -> Html Msg
leftProfileNameColumn name =
    div [ class "column" ]
        [ h4 [ class "title is-4" ] [ text name ]
        ]


leftDescriptionColumn : String -> Html Msg
leftDescriptionColumn bio =
    div [ class "column" ]
        [ p [ class "is-size-6 has-text-grey" ] [ text bio ]
        ]


leftLinkColumn : Html Msg
leftLinkColumn =
    div [ class "column" ]
        [ viewLink "Blogs"
        , viewLink "Projects"
        , viewLink "Rants"
        , viewLink "Talks"
        ]


viewLink : String -> Html Msg
viewLink path =
    div [] [ a [ href path ] [ text path ] ]


leftContactColumn : Html Msg
leftContactColumn =
    div [ class "column" ]
        [ contactLink "0 0 26 28" "M10 19c0 1.141-0.594 3-2 3s-2-1.859-2-3 0.594-3 2-3 2 1.859 2 3zM20 19c0 1.141-0.594 3-2 3s-2-1.859-2-3 0.594-3 2-3 2 1.859 2 3zM22.5 19c0-2.391-1.453-4.5-4-4.5-1.031 0-2.016 0.187-3.047 0.328-0.812 0.125-1.625 0.172-2.453 0.172s-1.641-0.047-2.453-0.172c-1.016-0.141-2.016-0.328-3.047-0.328-2.547 0-4 2.109-4 4.5 0 4.781 4.375 5.516 8.188 5.516h2.625c3.813 0 8.188-0.734 8.188-5.516zM26 16.25c0 1.734-0.172 3.578-0.953 5.172-2.063 4.172-7.734 4.578-11.797 4.578-4.125 0-10.141-0.359-12.281-4.578-0.797-1.578-0.969-3.437-0.969-5.172 0-2.281 0.625-4.438 2.125-6.188-0.281-0.859-0.422-1.766-0.422-2.656 0-1.172 0.266-2.344 0.797-3.406 2.469 0 4.047 1.078 5.922 2.547 1.578-0.375 3.203-0.547 4.828-0.547 1.469 0 2.953 0.156 4.375 0.5 1.859-1.453 3.437-2.5 5.875-2.5 0.531 1.062 0.797 2.234 0.797 3.406 0 0.891-0.141 1.781-0.422 2.625 1.5 1.766 2.125 3.938 2.125 6.219z"
        , contactLink "0 0 430.117 430.117" "M430.117,261.543V420.56h-92.188V272.193c0-37.271-13.334-62.707-46.703-62.707c-25.473,0-40.632,17.142-47.301,33.724c-2.432,5.928-3.058,14.179-3.058,22.477V420.56h-92.219c0,0,1.242-251.285,0-277.32h92.21v39.309c-0.187,0.294-0.43,0.611-0.606,0.896h0.606v-0.896c12.251-18.869,34.13-45.824,83.102-45.824C384.633,136.724,430.117,176.361,430.117,261.543z M52.183,9.558C20.635,9.558,0,30.251,0,57.463c0,26.619,20.038,47.94,50.959,47.94h0.616c32.159,0,52.159-21.317,52.159-47.94C103.128,30.251,83.734,9.558,52.183,9.558zM5.477,420.56h92.184v-277.32H5.477V420.56z"
        , contactLink "0 0 28 28" "M26 23.5v-12c-0.328 0.375-0.688 0.719-1.078 1.031-2.234 1.719-4.484 3.469-6.656 5.281-1.172 0.984-2.625 2.188-4.25 2.188h-0.031c-1.625 0-3.078-1.203-4.25-2.188-2.172-1.813-4.422-3.563-6.656-5.281-0.391-0.313-0.75-0.656-1.078-1.031v12c0 0.266 0.234 0.5 0.5 0.5h23c0.266 0 0.5-0.234 0.5-0.5zM26 7.078c0-0.391 0.094-1.078-0.5-1.078h-23c-0.266 0-0.5 0.234-0.5 0.5 0 1.781 0.891 3.328 2.297 4.438 2.094 1.641 4.188 3.297 6.266 4.953 0.828 0.672 2.328 2.109 3.422 2.109h0.031c1.094 0 2.594-1.437 3.422-2.109 2.078-1.656 4.172-3.313 6.266-4.953 1.016-0.797 2.297-2.531 2.297-3.859zM28 6.5v17c0 1.375-1.125 2.5-2.5 2.5h-23c-1.375 0-2.5-1.125-2.5-2.5v-17c0-1.375 1.125-2.5 2.5-2.5h23c1.375 0 2.5 1.125 2.5 2.5z"
        ]


contactLink : String -> String -> Html Msg
contactLink viewBox path =
    a
        [ style "border" "1px solid #ebebeb"
        , style "border-radius" "50%"
        , style "display" "inline-block"
        , style "width" "2.1875rem"
        , style "height" "35px"
        , style "margin-right" "6px"
        ]
        [ span [ class "icon is-small", style "margin" "8px" ]
            [ SVG.svg
                [ SvgAttr.viewBox viewBox ]
                [ SVG.path
                    [ SvgAttr.d path ]
                    []
                ]
            ]
        ]
