module Models exposing (..)

import Http exposing (Error)
import Dict exposing (Dict)
import Date exposing (Date)

import Cookie exposing (Error)

-- models for each components
type alias TableRowProps =
  { config : TableConfigList
  , row : TableRow
  , selected : Bool
  , selectedName : String
  , current : Date.Date
  }

type alias TableRowModel =
  { props : TableRowProps
  }

type alias TableProps =
  { config : TableConfigList
  , rows : RowList
  , selectedName : String
  , current : Date.Date
  }

type alias TableState =
  { selectedName : String
  , selectedRow : TableRow
  , sortAttr : String
  , sortPolarity : Bool
  }

type alias TableModel =
  { props : TableProps
  , state : TableState
  }

type alias TablePaginatorProps =
  { rows : RowList,
    nRows : Int,
    i : Int
  }

type alias TablePaginatorModel =
  { props : TablePaginatorProps
  }

type alias TableWrapperProps =
  { config : TableConfigList
  , rows : RowList
  , nRows : Int
  , selectedName : String
  , current : Date.Date
  }

type alias TableWrapperState =
  { currentPage : Int
  , sortAttr : String
  , sortPolarity : Bool
  , selectedRow : TableRow
  , sortAttr : String
  , sortPolarity : Bool
  }

type alias TableWrapperModel =
  { props : TableWrapperProps
  , state : TableWrapperState
  }

type alias NavProps =
  { title : String
  , leaguename : String
  , leagues : List League
  , username : String
  , loggedIn : Bool
  }

type alias NavModel =
  { props : NavProps }

type alias DashProps =
  { leaguename : String
  , current : Date.Date
  }

type alias DashState =
  { selectedTab : String
  , rows: RowList
  , currentPage : Int
  , selectedRow : TableRow
  , sortAttr : String
  , sortPolarity : Bool
  }

type alias DashModel =
  { props : DashProps
  , state : DashState
  }

-- global model
type alias Model =
  { leagues: List League
  , users: List User
  , username: String
  , password: String
  , leaguename: String
  , loggedIn : Bool
  , current: Date.Date
  , selectedTab : String
  , rows: RowList
  , currentPage : Int
  , selectedRow : TableRow
  , sortAttr : String
  , sortPolarity : Bool
  }

type Action
  = NoOp
  | HandleLogin
  | HandleLoginResult (Result Cookie.Error ())
  | HandleLogoutResult (Result Cookie.Error ())
  | HandleGetCookieResult (Result Cookie.Error String)
  | HandleLogout
  | HandleInputUserName String
  | HandleInputPassword String
  | HandleLeagueChanged String
  | HandleTabClicked Tab
  | HandleFetchData
  | HandleFetchFixtures (Result Http.Error (List Fixture))
  | HandleFetchOutrights (Result Http.Error (List Outright))
  | HandleFetchTeams (Result Http.Error (List Team))
  | HandleRowSelected TableConfigItem TableRow
  | HandleSorterClicked TableConfigItem
  | HandlePageClicked VL
  | SetNow Date

type alias User =
 { name : String
 , password : String
 }

type alias League =
 { name : String
 }

type alias Fixture =
  { price_1 : Float
  , price_2 : Float
  , price_X : Float
  , league : String
  , name : String
  , kickoff : String
  , key : String
  }

type alias Outright =
  { status : String
  , league : String
  , price : Float
  , key : String
  , team : String
  , market: String
  }

type alias Team =
  { status : String
  , neokal_mu0 : Float
  , name : String
  , played : Int
  , goal_difference : Int
  , expected_season_points : Float
  , points : Int
  , key : String
  , neokal_mu : Float
  , neokal_vol : Float
  , ppg_rating : Float
  }

type alias Tab =
  { name : String
  , label : String
  }

type alias TabList = List Tab

type alias TableConfigItem =
  { name : String
  , label : String
  , format : String
  , muted : Bool
  }

type alias TableConfigList = List TableConfigItem

type alias TableConfig = Dict String TableConfigList

type alias TableRow = Dict String String

type alias RowList = List TableRow

type alias VL =
  { value : Int
  , label : String
  }
