module Components.Table.TableWrapper
  exposing
    (..)

import Html exposing (..)
import Array exposing (Array)
import Dict exposing (Dict)

import Models exposing (..)
import Components.Table.Table as Table exposing (uiTable)
import Components.Table.TablePaginator as TablePaginator exposing (tablePaginator)
import Utils.DateHelpers exposing (currentDate)

-- model
tableWrapper : TableWrapperModel -> Html Action
tableWrapper model =
  let
    props = model.props
    state = model.state

    tableSorter : TableRow -> TableRow -> Order
    tableSorter item0 item1 =
      let
        value0 = Maybe.withDefault "" (Dict.get state.sortAttr item0)
        value1 = Maybe.withDefault "" (Dict.get state.sortAttr item1)

      in
        if state.sortPolarity then
          if value0 < value1 then
            GT
          else if value0 > value1 then
            LT
          else
            EQ
        else
          if value0 > value1 then
            GT
          else if value0 < value1 then
            LT
          else
            EQ

    sortRows: RowList -> RowList
    sortRows rows =
      if (state.sortAttr == "") then
        rows
      else
        List.sortWith tableSorter rows

    filterRows: Int -> RowList -> RowList
    filterRows currentPage rows =
      let
        i = currentPage * props.nRows
        j = (currentPage + 1) * props.nRows
        l = Array.fromList rows
        n = Basics.min j (Array.length l)
        r = Array.slice i n l
      in
        Array.toList r

    filteredRows : RowList
    filteredRows = filterRows state.currentPage (sortRows props.rows)

    tableProps : TableProps
    tableProps =
      { config = props.config
      , rows = filteredRows
      , selectedName = props.selectedName
      , current = props.current
      }

    tableState : TableState
    tableState =
      { selectedName = props.selectedName
      , selectedRow = state.selectedRow
      , sortAttr = state.sortAttr
      , sortPolarity = state.sortPolarity
      }

    tableModel : TableModel
    tableModel =
      { props = tableProps
      , state = tableState
      }

    tablePaginatorProps : TablePaginatorProps
    tablePaginatorProps =
      { rows = props.rows
      , nRows = props.nRows
      , i = state.currentPage
      }

    tablePaginatorModel : TablePaginatorModel
    tablePaginatorModel =
      { props = tablePaginatorProps }

    tablePaginator2 =
      let
        length = List.length props.rows
      in
        if length > props.nRows then
          tablePaginator tablePaginatorModel
        else
          div [][]
  in
    div []
      [ uiTable tableModel
      , tablePaginator2
      ]
