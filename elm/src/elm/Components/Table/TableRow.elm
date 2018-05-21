module Components.Table.TableRow
  exposing
    (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick, on)
import Date exposing (fromString, now)
import Date.Extra as Date
import Dict

import Models exposing (..)
import Utils.Math exposing (toFixed)
import Utils.DateHelpers as DateHelpers

-- helper functions
toFloat : String -> Float
toFloat value =
  String.toFloat value |> Result.withDefault (0)

dateFromString : String -> Date.Date
dateFromString value =
  Date.fromString value |> Result.withDefault (Date.fromTime 0)

formatLabel: String -> String -> Html msg
formatLabel value klass =
  let
    labelClass = "label label-" ++ klass
  in
    span [ class labelClass ][
      text value
    ]

formatDatetimeLabel: String -> Date.Date -> Html msg
formatDatetimeLabel value now =
  let
    date : Date.Date
    date = dateFromString value
    today = now
    tmrw = Date.add Date.Day 1 today
  in
    if ((Date.month date == Date.month today) &&
        (Date.day date == Date.day today)) then
      let
        today = "Today " ++ (DateHelpers.formatTime date)
      in
        formatLabel today "warning"
    else if ((Date.month date == Date.month tmrw) &&
      (Date.day date == Date.day tmrw)) then
      formatLabel "Tomorrow" "info"
    else
      text (DateHelpers.formatDate date)

formatDatetime: String -> Date.Date -> String
formatDatetime value now =
  let
    date : Date.Date
    date = dateFromString value
    today = now
  in
    if ((Date.month date == Date.month today) &&
        (Date.day date == Date.day today)) then
      DateHelpers.formatTime date
    else
      DateHelpers.formatDate date

formatPrice : String -> String
formatPrice value =
  let
    f : Float
    f = String.toFloat value |> Result.withDefault (0)
  in
    if f < 10 then
      toFixed f 2
    else if f < 100 then
      toFixed f 1
    else
      toFixed f 0

formatAmount : String -> String
formatAmount value =
  let
    f : Float
    f = String.toFloat value |> Result.withDefault (0)
    a : Float
    a = abs f
  in
    if a < 1000 then
      toString (floor f)
    else if a < 10000 then
      toFixed (f / 1000) 1 ++ "K"
    else
      toString (floor (f / 1000)) ++ "K"

formatFloat: String -> Int -> String
formatFloat value dp =
  let
    f : Float
    f = toFloat value
  in
    toFixed f dp

formatPct: String -> Int -> String
formatPct value dp =
  let
    f : Float
    f = toFloat value
  in
    toFixed (100 * f) dp ++ "%"

formatValue: TableConfigItem -> Dict.Dict String String -> Date.Date -> Html Action
formatValue col row current =
  let
    v : Maybe String
    v = Dict.get col.name row

    value : String
    value = Maybe.withDefault "" v
  in
    if value == "" then
      text ""
    else
      case col.format of
        "datetime_label" ->
          formatDatetimeLabel value current
        "datetime" ->
          text (formatDatetime value current)
        "price" ->
          text (formatPrice value)
        "amount" ->
          text (formatAmount value)
        "float1" ->
          text (formatFloat value 1)
        "float2" ->
          text (formatFloat value 2)
        "float3" ->
          text (formatFloat value 3)
        "pct1" ->
          text (formatPct value 1)
        "pct2" ->
          text (formatPct value 2)
        "pct3" ->
          text (formatPct value 3)
        _ ->
          text value

tableRow : TableRowModel -> Html Action
tableRow model =
  let
    props = model.props

    rowClass : String
    rowClass =
      if props.selected then
        "selected"
      else
        ""

    colClass: TableConfigItem -> String
    colClass col =
      if col.muted then
        "text-center text-muted"
      else
        "text-center"

    cellValue: TableConfigItem -> TableRow -> Html Action
    cellValue col row =
      formatValue col row model.props.current

    toTableColumn : TableConfigItem -> Html Action
    toTableColumn col =
      let
        cell = cellValue col props.row
        cellClass = colClass col
      in
        td [ class cellClass, onClick (HandleRowSelected col props.row) ][
          cell
        ]
  in
    tr [ class rowClass ]
      (List.map toTableColumn props.config)
