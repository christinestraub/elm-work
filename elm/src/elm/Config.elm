module Config
  exposing
    (..)

import Dict exposing (Dict)
import Models exposing (TableConfigList, TableConfig, User, League)

teams : TableConfigList
teams = [
  { name = "name"
  , label = "Team"
  , format = ""
  , muted = False
  },
  { name = "points"
  , label = "Points"
  , format = ""
  , muted = False
  },
  { name = "goal_difference"
  , label =  "Goal Diff"
  , format = ""
  , muted = False
  },
  { name = "played"
  , label =  "Played"
  , format = ""
  , muted = False
  },
  { name = "expected_season_points"
  , label =  "Exp Season Pts"
  , format =  "float2"
  , muted = False
  },
  { name = "ppg_rating"
  , label =  "PPG Rating"
  , format =  "float3"
  , muted = False
  }
  ]

fixtures : TableConfigList
fixtures = [
  { name = "kickoff"
  , label =  "Kickoff"
  , format =  "datetime"
  , muted = False
  },
  { name = "name"
  , label = "Event"
  , format = ""
  , muted = False
  },
  { name = "price_1"
  , label =  "[1]"
  , format =  "price"
  , muted = False
  },
  { name = "price_X"
  , label =  "[X]"
  , format =  "price"
  , muted = False
  },
  { name = "price_2"
  , label =  "[2]"
  , format =  "price"
  , muted = False
  }
  ]

outrights : TableConfigList
outrights = [
  { name = "market"
  , label = "Market"
  , format = ""
  , muted = False
  },
  { name = "team"
  , label = "Team"
  , format = ""
  , muted = False
  },
  { name = "price"
  , label = "Price"
  , format = "price"
  , muted = False
  }
  ]

tableConfig : TableConfig
tableConfig = Dict.fromList
  [ ("teams", teams)
  , ("fixtures", fixtures)
  , ("outrights", outrights)
  ]

leagues : List League
leagues = [{ name = "ENG.1" }, { name = "ENG.2" }, { name = "FRA.1" }, { name = "GER.1" }, { name = "SPA.1" }]

users : List User
users = [{ name = "justin", password = "hello" }]
