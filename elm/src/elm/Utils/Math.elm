module Utils.Math
 exposing
  (..)

import String exposing (padRight, split, join)


toFixed : Float -> Int -> String
toFixed value precision =
    let
        power =
            toFloat 10 ^ (toFloat precision)

        pad num =
            case num of
                [ x, y ] ->
                    [ x, String.padRight precision '0' y ]

                [ val ] ->
                    [ val, String.padRight precision '0' "" ]

                val ->
                    val
    in
        (round (value * power) |> toFloat)
            / power
            |> toString
            |> String.split "."
            |> pad
            |> String.join "."
