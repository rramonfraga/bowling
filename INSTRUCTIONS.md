# Bowling game

## Installation

Verify that you have the next version of Elixir and Erlang:

- Elixir 1.14.5
- Erlang 26.0

You can check https://hexdocs.pm/phoenix/installation.html to be sure how install elixir, erlang and phoenix.

Run the following command to start the Phoenix server:

```
mix phx.server
```

Use the url http://localhost:4000 to access the Phoenix application.

## Documentation

For all the documentation, please go to the documentation file: /DOCUMENTATION.md

## Choises

The first major decision made was to not choose a database to store the game state. Instead, a dynamic supervisor was implemented to individually monitor each game and store the game state in a GenServer. Considerations:

- Each game is independent from the others. If an error occurs in one game, it will not affect the others.
- The number of lanes per bowling alley is limited, so there shouldn't be too many concurrent processes.
- The state of previous games is not stored as it is not essential for the bowling functionality.
- The current game state can be lost in case of a failure.

If any of these considerations are no longer valid or if a specific consideration becomes more important, a cache can be added or the entire supervisor can be replaced with a database.

Another consideration taken into account is that each bowling lane assigns the ID to the game to avoid collision issues or requiring the front-end to memorize an ID. This could potentially create collisions if multiple bowling alleys have the same ID, but it can be easily resolved by eliminating it.

The score calculation is recalculated for each frame. It was preferred to avoid complexity in the game state and models. Since the number of frames is limited to 10, it won't be a significant resource burden, but optimization can be considered in the future.

The system also supports multiple players to provide a complete bowling experience.

## Improves

Things that are still pending or could be improved:

- Implementing a game completion and restart system.
- Improving the scoring calculation for optimization purposes.
- Add a external cache to save the game status for restarts or downs.
- Add metrics and observability for keeping track the healthy of endpoints
- Add all reelse staff for deplying it to production.