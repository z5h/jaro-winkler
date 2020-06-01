module Test1 exposing (main)

import Browser
import Html exposing (Attribute, Html, br, button, div, h1, h2, input, p, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import JaroWinkler


type alias Model =
    { sentences : List String
    , results : List String
    }


sentences : List String
sentences =
    [ "I am looking for a good solution"
    , "the happiest man in the world is here"
    , "It is time to go outside."
    , "Luckily the covid 19 pandamec came to an end."
    ]


initialModel : Model
initialModel =
    { sentences = sentences
    , results = []
    }


type Msg
    = WordEntered String


update : Msg -> Model -> Model
update msg model =
    case msg of
        WordEntered word ->
            { model
                | results =
                    model.sentences
                        |> List.sortBy (JaroWinkler.similarity word)
            }


rowItem : String -> Html Msg
rowItem id =
    div
        [ style "background-color" "#AFEEEE"
        , style "border" "1px solid white"
        , style "border-radius" "10px"
        , style "padding" "10px"
        ]
        [ text id ]


view : Model -> Html Msg
view model =
    let
        results =
            model.results
                |> List.map
                    (\result ->
                        div [] []
                    )
    in
    div [ style "text-align" "center" ]
        [ div [ style "border" "2px solid black", style "border-radius" "10px", style "width" "50%" ]
            [ input [ placeholder "word", onInput WordEntered, style "padding" "5px 5px" ] []
            , button [ style "background-color" "#8B0000", style "padding" "5px 5px", style "border-radius" "8px", style "color" "white" ] [ text "Search" ]
            , div [] (List.map rowItem model.results)
            , br [] []
            ]
        ]


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
