module Components.Table.Table
  exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick, on)
import Dict exposing (Dict)

import Components.Table.TableRow as TableRow exposing (..)
import Models exposing (..)

uiTable : TableModel -> Html Models.Action
uiTable model =
  let
    props : TableProps
    props = model.props

    state : TableState
    state = model.state

    isSelected : TableRow -> Bool
    isSelected row =
      if (state.selectedRow == Dict.empty) then
        False
      else
        let
          key = Maybe.withDefault "" (Dict.get "key" row)
          selectedKey = Maybe.withDefault "" (Dict.get "key" state.selectedRow)
        in
          key == selectedKey

    toTableColumn : TableConfigItem -> Html Models.Action
    toTableColumn item =
      th [ class "text-center", onClick (HandleSorterClicked item) ][
        text item.label
      ]

    toTableRow : TableRow -> Html Models.Action
    toTableRow row =
      let
        tableRowProps : TableRowProps
        tableRowProps =
          { config = props.config
          , row = row
          , selected = isSelected row
          , selectedName = ""
          , current = props.current
          }

        tableRowModel : TableRowModel
        tableRowModel =
          { props = tableRowProps
          }
      in
        tableRow tableRowModel
  in
    table [ class "table table-striped table-condensed table-bordered" ][
      thead []
        (List.map toTableColumn props.config)
      ,
      tbody []
        (List.map toTableRow props.rows)
    ]
