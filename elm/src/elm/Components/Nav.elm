module Components.Nav
  exposing
    (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick, on, targetValue)
import Json.Decode as Json
-- import Html.Events.Extra exposing (targetValueIntParse)

import Models exposing (..)

-- https://github.com/circuithub/elm-html-extra/blob/1.5.2/src/Html/Events/Extra.elm
{-| Parse an integer value from the input instead of using `valueAsNumber`.
Use this with inputs that do not have a `number` type.
-}
-- targetValueIntParse : Json.Decoder Int
-- targetValueIntParse =
--   Json.decodeInt targetValue String.toInt

-- Nav component
nav : NavModel -> Html Action
nav model =
  let
    props = model.props

    loginForm =
      let
        -- 
        greeting : String
        greeting =
          "Hello " ++ props.username ++ ":)"

        leagueOption : League -> Html Action
        leagueOption league = 
          option [ value league.name ][
            text league.name
          ]
      in
        if props.loggedIn then
          div [][
            ul [ class "nav navbar-nav navbar-right" ][
              li [ style [("margin-right", "3px")] ][
                a [ attribute "href" "#" ][ text "League" ]
              ],
              li [ style [("margin-top", "7px")] ][
                select [
                  class "form-control",
                  on "change" <| Json.map HandleLeagueChanged <| Json.at ["target", "value"] Json.string
                ]
                  (List.map leagueOption props.leagues)
              ],
              li [ onClick HandleLogout ][
                a [ attribute "href" "#" ][ text "Logout" ]
              ]
            ],
            div [ attribute "id" "message", class "div-username" ][
              text greeting
            ]
          ]
        else
          ul [ class "nav navbar-nav navbar-right list-inline" ][
            li [][
              label [ style [("margin-top", "17px")] ][ text "Username" ]
            ],
            li [][
              input [
                type_ "text",
                attribute "id" "username",
                class "form-control",
                style [("margin-top", "7px")],
                onInput HandleInputUserName
              ][]
            ],
            li [][
              label [ style [("margin-top", "17px")] ][ text "Password" ]
            ],
            li [][
              input [
                type_ "password",
                attribute "id" "password",
                class "form-control",
                style [("margin-top", "7px")],
                onInput HandleInputPassword
              ][]
            ],
            li [][
              button [ class "btn btn-default btn-login", onClick HandleLogin ][ text "Login" ]
            ]
          ]
  in
    div [ class "navbar navbar-inverse navbar-fixed-top" ][
      div [ class "container-fluid" ][
        div [ class "navbar-header" ][
          button [
            class "navbar-toggle collapsed",
            attribute "data-toggle" "collapse",
            attribute "data-target" "#navbar",
            attribute "aria-expanded" "false",
            attribute "aria-controls" "navbar"
          ][
            span [ class "sr-only" ][ text "Toggle navigation" ]
          ],
          a [ class "navbar-brand" ][ text props.title ]
        ],
        div [ attribute "id" "navbar", class "navbar-collapse collapse" ][
          loginForm
        ]
      ]
    ]

-- CSS STYLES
styles :
  {
    btnLogin : List ( String, String ),
    divUsername : List ( String, String )
  }
styles =
  {
    btnLogin =
      [ ( "width", "33%" )
      , ( "border", "4px solid #337AB7")
      ],
    divUsername = 
      [
        ("position", "fixed"),
        ("top", "0"),
        ("right", "250px"),
        ("z-index", "9999"),
        ("padding-top", "5px"),
        ("padding-bottom", "5px"),
        ("margin-top", "12px")
      ]
  }