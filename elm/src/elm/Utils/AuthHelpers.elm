module Utils.AuthHelpers
  exposing
    (..)

import Task exposing (Task)
import Cookie exposing (..)

import Models exposing (..)

cookieName = "upwork-ui"

options : Cookie.Options
options =
  { domain = Nothing
  , path = Nothing
  , maxAge = Nothing
  , secure = False
  }

setUserToken : String -> Task Cookie.Error ()
setUserToken token =
  Cookie.set options cookieName token

getUserToken : Cmd Action
getUserToken =
  Task.attempt HandleGetCookieResult Cookie.get
