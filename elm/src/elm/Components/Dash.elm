module Components.Dash
  exposing
    (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Dict
import List

import Models exposing (..)
import Config exposing (tableConfig)
import Components.Table.TableWrapper as TableWrapper exposing (tableWrapper)

-- Dash model
tabs : TabList
tabs = [
  { name = "teams"
  , label = "Teams"
  },
  { name = "fixtures"
  , label = "Fixtures"
  },
  { name = "outrights"
  , label = "Outrights"
  }]

toTab : Tab -> Html Action
toTab tab =
  li [ onClick (Models.HandleTabClicked tab) ][
    a [ attribute "href" "#" ][ text tab.name ]
  ]

-- Dash component
dash : DashModel -> Html Action
dash model =
  let
    props = model.props
    state = model.state

    config = Maybe.withDefault [] (Dict.get state.selectedTab tableConfig)

    tableWrapperProps : TableWrapperProps
    tableWrapperProps =
      { config = config
      , rows = state.rows
      , nRows = 20
      , selectedName = ""
      , current = props.current
      }

    tableWrapperState : TableWrapperState
    tableWrapperState =
      { currentPage = state.currentPage
      , selectedRow = state.selectedRow
      , sortAttr = state.sortAttr
      , sortPolarity = state.sortPolarity
      }

    tableWrapperModel : TableWrapperModel
    tableWrapperModel =
      { props = tableWrapperProps
      , state = tableWrapperState
      }
  in
    div [ class "text-center", style [("margin-top", "80px")] ][
      ul [ class "nav nav-tabs" ]
        (List.map toTab tabs)
      ,
      div [ style [("margin-top", "20px")]][
         tableWrapper tableWrapperModel
      ]
    ]
