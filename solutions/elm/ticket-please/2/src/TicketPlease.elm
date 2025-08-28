module TicketPlease exposing (..)

import TicketPleaseSupport exposing (Status(..), Ticket(..), User(..))


emptyComment : ( User, String ) -> Bool
emptyComment ( _, comment ) =
    String.isEmpty comment


numberOfCreatorComments : Ticket -> Int
numberOfCreatorComments (Ticket { comments, createdBy }) =
    let
        ( ticketCreator, _ ) =
            createdBy
    in
    comments
        |> List.filter (\( commentCreator, _ ) -> commentCreator == ticketCreator)
        |> List.length


assignedToDevTeam : Ticket -> Bool
assignedToDevTeam (Ticket { assignedTo }) =
    case assignedTo of
        Just (User user) ->
            case user of
                "Alice" ->
                    True

                "Bob" ->
                    True

                "Charlie" ->
                    True

                _ ->
                    False

        _ ->
            False


assignTicketTo : User -> Ticket -> Ticket
assignTicketTo newUser (Ticket ({ status } as t)) =
    Ticket <|
        case status of
            New ->
                { t | status = InProgress, assignedTo = Just newUser }

            Archived ->
                t

            _ ->
                { t | assignedTo = Just newUser }
