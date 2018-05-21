module Utils.HttpHelpers
  exposing
    (..)

import Http
import String.Extra as String exposing (..)

import Models exposing (..)
import Utils.DecodeHelpers exposing (..)

fetchData : String -> String -> Cmd Action
fetchData leaguename attr =
  let
    url = String.concat
      [ "http://localhost:8080/elm/Fixtures/"
      , (String.replace "." "~" leaguename)
      , "~"
      , attr
      , ".json"
      ]
  in
    case attr of
      "fixtures" ->
        Http.send HandleFetchFixtures (Http.get url decodeFixtures)

      "outrights" ->
        Http.send HandleFetchOutrights (Http.get url decodeOutrights)

      "teams" ->
        Http.send HandleFetchTeams (Http.get url decodeTeams)

      _ ->
        Cmd.none
