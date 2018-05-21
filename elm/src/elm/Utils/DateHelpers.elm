module Utils.DateHelpers
  exposing
   (..)

import Array exposing (Array)
import Date exposing (Date)
import Task
import Date.Extra

import Models exposing (Action)

formatMonth : Date -> String
formatMonth date =
  let
    months : Array String
    months = Array.fromList ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    month: Maybe String
    month = Array.get (Date.Extra.monthToNumber (Date.month date)) months
  in
    month |> Maybe.withDefault ""

formatDaySuffix: Date -> String
formatDaySuffix date =
  let
    day : Int
    day = Date.day date
  in
    if ((day == 1) || (day == 21) || (day == 31)) then
      "st"
    else if ((day == 2) || (day == 22)) then
      "nd"
    else if ((day == 3) || (day == 23)) then
      "rd"
    else
      "th"

formatDate : Date -> String
formatDate date =
  let
    month = formatMonth date
    suffix = formatDaySuffix date
    day = Date.day date
  in
    month ++ " " ++ (toString day) ++ suffix

formatMinutes : Date -> String
formatMinutes date =
  let
    minutes : Int
    minutes = Date.minute date
  in
    if (minutes < 10) then
      "0" ++ toString minutes
    else
      toString minutes

formatTime : Date -> String
formatTime date =
  toString (Date.hour date) ++ ":" ++ formatMinutes date

currentDate : Date
currentDate =
  Date.fromString "2018-04-01 00:00:00.000Z" |> Result.withDefault (Date.fromTime 0)

--getNow: Cmd Action
--getNow =
--  Task.perform (Just >> Models.SetNow) Date.now
