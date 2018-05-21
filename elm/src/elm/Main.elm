module Main
  exposing
    (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import String
import Task
import Array
import Dict exposing (Dict)
import Task exposing (Task)

import Models exposing (..)
import Components.Nav as Nav
import Components.Dash as Dash
import Config exposing (users, leagues, tableConfig)
import Utils.DecodeHelpers exposing (..)
import Utils.DateHelpers exposing (currentDate)
import Utils.HttpHelpers exposing (fetchData)
import Utils.AuthHelpers exposing (..)

-- MODEL
leaguename : String
leaguename = "ENG.1"

tab : String
tab = "teams"

-- APP
main : Program Never Model Action
main =
  Html.program
    { init = init
    , update   = update
    , view = view
    , subscriptions = subscriptions
    }

init : ( Model, Cmd Action )
init =
    ({ leagues = leagues
     , users = users
     , username = ""
     , password = ""
     , leaguename = leaguename
     , loggedIn = False
     , selectedTab = tab
     , current = currentDate
     , rows = []
     , currentPage = 0
     , selectedRow = Dict.empty
     , sortAttr = ""
     , sortPolarity = False
     }, getUserToken)

-- UPDATE
update : Models.Action -> Model -> (Model, Cmd Action)
update action model =
  case action of
    SetNow current ->
      ({ model | current = current }, Cmd.none)
  
    HandleLogin ->
      let
        checkUser : User -> Bool
        checkUser user =
          (user.name == model.username) && (user.password == model.password)

        matchedUsers : List User
        matchedUsers = List.filter checkUser model.users
      in
        if List.length matchedUsers > 0 then
          let
            emptyUser : User
            emptyUser =
              {
                name = "",
                password = ""
              }
            user = Maybe.withDefault emptyUser (List.head matchedUsers)
          in
            ({ model | username = user.name }
            , Task.attempt HandleLoginResult (setUserToken user.name))
        else
          (model, Cmd.none)

    HandleLoginResult res ->
      case res of
        Ok () ->
          update HandleFetchData { model | loggedIn = True }

        Err err ->
          (model, Cmd.none)

    HandleLogout ->
      ({ model | username = "", loggedIn = False }
      , Task.attempt HandleLogoutResult (setUserToken ""))

    HandleLogoutResult res ->
      case res of
        Ok () ->
          ({ model | loggedIn = False, rows = [] }, Cmd.none)

        Err err ->
          (model, Cmd.none)

    HandleGetCookieResult res ->
      case res of
        Ok cookie ->
          let
            values = String.split ";" cookie
            ul = List.filterMap (
              \x ->
                let
                  kv = Array.fromList (String.split "=" x)
                  k = Maybe.withDefault "" (Array.get 0 kv)
                  v = Maybe.withDefault "" (Array.get 1 kv)
                in
                  if k == cookieName && v /= "" then
                    Just v
                  else
                    Nothing
              ) values
            username = Maybe.withDefault "" (List.head ul)
          in
            if username == "" then
              (model , Cmd.none)
            else
              update HandleFetchData { model | username = username, loggedIn = True }

        Err err ->
          (model, Cmd.none)

    HandleInputUserName value ->
      ({ model | username = value }, Cmd.none)

    HandleInputPassword value ->
      ({ model | password = value }, Cmd.none)

    HandleLeagueChanged value ->
      update HandleFetchData { model | leaguename = value }

    HandleTabClicked tab ->
      update HandleFetchData { model | selectedTab = tab.name, currentPage = 0 }

    HandleFetchData ->
      let
        cmd = fetchData model.leaguename model.selectedTab
      in
        (model, cmd)

    HandleFetchFixtures (Ok data) ->
      let
        rows = fixturesToRowList data
      in
        ({ model | rows = rows }, Cmd.none)

    HandleFetchOutrights (Ok data) ->
      let
        rows = outrightsToRowList data
      in
        ({ model | rows = rows }, Cmd.none)

    HandleFetchTeams (Ok data) ->
      let
        rows = teamsToRowList data
      in
        ({ model | rows = rows }, Cmd.none)

    HandlePageClicked item ->
      ({ model | currentPage = item.value }, Cmd.none)

    HandleRowSelected col row ->
      ({ model | selectedRow = row }, Cmd.none)

    HandleSorterClicked item ->
       ({ model | sortAttr = item.name, sortPolarity = not model.sortPolarity }, Cmd.none)

    _ ->
      (model, Cmd.none)

-- VIEW
-- Html is defined as: elem [ attribs ][ children ]
-- CSS can be applied via class names or inline style attrib
view : Model -> Html Models.Action
view model =
  let
    navProps : NavProps
    navProps =
      { title = "Upwork UI"
      , leaguename = model.leaguename
      , leagues = model.leagues
      , username = model.username
      , loggedIn = model.loggedIn
      }

    navModel : NavModel
    navModel =
      { props = navProps
      }

    dashProps : DashProps
    dashProps =
      { leaguename = model.leaguename
      , current = model.current
      }

    dashState : DashState
    dashState =
      { selectedTab = model.selectedTab
      , rows = model.rows
      , currentPage = model.currentPage
      , selectedRow = model.selectedRow
      , sortAttr = model.sortAttr
      , sortPolarity = model.sortPolarity
      }

    dashModel : DashModel
    dashModel =
      { props = dashProps
      , state = dashState
      }

    dash2 =
      if model.loggedIn then
        Dash.dash dashModel
      else
        div [][]
  in
    -- if the user is logged in, show dash; if logged out, show the login/register form
    div [ class "container-fluid" ]
      [ Nav.nav navModel
      , dash2
      ]

-- SUBSCRIPTIONS
subscriptions : Model -> Sub Action
subscriptions model =
    Sub.none

-- CSS STYLES
styles : { img : List ( String, String ) }
styles =
  {
    img =
      [ ( "width", "33%" )
      , ( "border", "4px solid #337AB7")
      ]
  }
