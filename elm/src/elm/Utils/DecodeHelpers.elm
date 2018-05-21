module Utils.DecodeHelpers
  exposing
    (..)

import Json.Decode as Decode exposing (Decoder, map7, map6, list, at, float, string, int, nullable)
import Json.Decode.Pipeline exposing (decode, required, optional, hardcoded)
import Dict exposing (Dict)

import Models exposing (Fixture, Outright, Team, TableRow, RowList)

decodeFixture : Decoder Fixture
decodeFixture =
  map7 Fixture
    (at ["price_1"] float)
    (at ["price_2"] float)
    (at ["price_X"] float)
    (at ["league"] string)
    (at ["name"] string)
    (at ["kickoff"] string)
    (at ["key"] string)

decodeFixtures : Decoder (List Fixture)
decodeFixtures =
  list decodeFixture

decodeOutright : Decoder Outright
decodeOutright =
  map6 Models.Outright
    (at ["status"] string)
    (at ["league"] string)
    (at ["price"] float)
    (at ["key"] string)
    (at ["team"] string)
    (at ["market"] string)

decodeOutrights : Decoder (List Outright)
decodeOutrights =
  list decodeOutright
  
decodeTeam : Decoder Team
decodeTeam =
  decode Team
    |> required "status" string
    |> required "neokal_mu0" float
    |> required "name" string
    |> required "played" int
    |> required "goal_difference" int
    |> required "expected_season_points" float
    |> required "points" int
    |> required "key" string
    |> required "neokal_mu" float
    |> required "neokal_vol" float
    |> required "ppg_rating" float

decodeTeams : Decoder (List Team)
decodeTeams =
  list decodeTeam

fixturesToRowList : List Fixture -> RowList
fixturesToRowList data =
  let
    toTableRow : Fixture -> TableRow
    toTableRow fixture =
      let
        cell : TableRow
        cell = Dict.fromList
          [ ("price_1", (toString fixture.price_1))
          , ("price_2", (toString fixture.price_2))
          , ("price_X", (toString fixture.price_X))
          , ("league", fixture.league)
          , ("name", fixture.name)
          , ("kickoff", fixture.kickoff)
          , ("key", fixture.key)
          , ("selected", "no")
          ]
      in
        cell
  in
    List.map toTableRow data

outrightsToRowList : List Outright -> RowList
outrightsToRowList data =
  let
    toTableRow : Outright -> TableRow
    toTableRow outright =
      let
        cell : TableRow
        cell = Dict.fromList
          [ ( "status", outright.status)
          , ("league", outright.league)
          , ("price", (toString outright.price))
          , ("key", outright.key)
          , ("team", outright.team)
          , ("market", outright.market)
          ]
      in
        cell
  in
    List.map toTableRow data

teamsToRowList : List Team -> RowList
teamsToRowList data =
  let
    toTableRow : Team -> TableRow
    toTableRow team =
      let
        cell : TableRow
        cell = Dict.fromList
          [ ("status", team.status)
          , ("neokal_mu0", (toString team.neokal_mu0))
          , ("name", team.name)
          , ("played", (toString team.played))
          , ("goal_difference", (toString team.goal_difference))
          , ("expected_season_points", (toString team.expected_season_points))
          , ("points", (toString team.points))
          , ("key", team.key)
          , ("neokal_mu", (toString team.neokal_mu))
          , ("neokal_vol", (toString team.neokal_vol))
          , ("ppg_rating", (toString team.ppg_rating))
          ]
      in
        cell
  in
    List.map toTableRow data
