module Components.Table.TablePaginator
  exposing
    (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick, on)

import Models exposing (..)

-- Dash model
initCells: RowList -> Int -> List VL
initCells rows nRows =
  let
    n = floor (toFloat (List.length rows) / toFloat nRows)
    items = List.range 0 n
    append : Int -> VL
    append i =
      { value = i, label = toString (i + 1) }
  in
    List.map append items


tablePaginator : TablePaginatorModel -> Html Action
tablePaginator model =
  let
    props = model.props
    cells = initCells props.rows props.nRows

    activeCell: VL -> String
    activeCell item =
      let
        active : Bool
        active = item.value == props.i
      in
        if active then
          "page-item active"
        else
          "page-item"

    pageItem : VL -> Html Action
    pageItem item =
      let
        itemClass = activeCell item
      in
        li [ class itemClass, onClick (HandlePageClicked item) ]
          [ a [ class "page-link" ] [ text item.label ]
          ]
  in
    ul [ class "pagination" ]
      (List.map pageItem cells)
