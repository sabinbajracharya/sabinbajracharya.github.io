
module UserInfo exposing (getUserInfo, UserInfo)

import Json.Decode exposing (Decoder, string, at, map3, decodeString, string, Error)

type alias UserInfo =
    { name : String
    , bio : String
    , profile_pic_url : String
    }

getUserInfo : Result Error UserInfo
getUserInfo =
    decodeString userinfoDecoder resUserInfo

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
