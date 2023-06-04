# Documentation

## Models

### Player

Represents a player participating in the game.

- name (string): The name of the player.
- frame_scores (array of integers): The scores achieved in each frame.
- frames (array of arrays): Detailed information about each frame.
- total_score (integer): The total score achieved by the player.

Example:
```
{
    "name": "Miguel",
    "frame_scores": [8, 5],
    "frames": [[0, 8], [5, 0], [1]],
    "total_score": 13
}
```

In the example, the player named "Miguel" has achieved scores of 8 and 5 in their first two frames. The frames array provides a detailed breakdown of each frame. The total_score is the cumulative score for all frames.

### Game

Represents a bowling game.

- id (string): The ID of the game. Should be associated with a lane of the bowling alley.
- current_player_name (string): The name of the current player.
- current_turn (integer): The current turn number.
- next_player_names (array of strings): The names of the players in the next turn.
- players (array of Player objects): Information about each player participating in the game.

Example:
```
{
    "id": "LANE-2",
    "current_player_name": "Miguel",
    "current_turn": 3,
    "next_player_names": ["Juan", "Mario"],
    "players": [
        {
            "name": "Miguel",
            "frame_scores": [8, 5],
            "frames": [[0, 8], [5, 0], [1]],
            "total_score": 13
        },
        {
            "name": "Juan",
            "frame_scores": [],
            "frames": [[10], [10]],
            "total_score": 0
        },
        {
            "name": "Mario",
            "frame_scores": [14, 4],
            "frames": [[10], [1, 3]],
            "total_score": 18
        }
    ]
}
```


## Endpoints

### Start a Game

This endpoint is done for start a new game.

#### Request

- Method: POST
- URL: /api/v1/game

#### Request Body

The request body should be a JSON object with the following structure:

```
{
    "game_id": "LANE-1",
    "players": ["Miguel"]
}
```

- game_id (string): The unique identifier for the game.
- players (array of strings): The list of player names participating in the game.

#### Response

The response will be a JSON object with the following structure:

```
{
    "game": {
        "id": "LANE-1",
        "current_player_name": "Miguel",
        "current_turn": 1,
        "next_player_names": [],
        "players": [
            {
                "name": "Miguel",
                "frame_scores": [],
                "frames": [],
                "total_score": 0
            }
        ]
    }
}
```

### Add falleng pins

This endpoint is done for add more follen pins in a game

#### Request

- Method: PATCH
- URL: /api/v1/game/:game_id

#### Request Body

The request body should be a JSON object with the following structure:

```
{
    "fallen_pins": 3
}
```

- fallen_pins (integer): The number of fallen pins.

#### Response

The response will be a JSON object with the following structure:

```
{
    "game": {
        "id": "LANE-1",
        "current_player_name": "Miguel",
        "current_turn": 1,
        "next_player_names": [],
        "players": [
            {
                "name": "Miguel",
                "frame_scores": [],
                "frames": [[3]],
                "total_score": 0
            }
        ]
    }
}
```

### Get a game

This endpoint is find the game information

#### Request

- Method: GET
- URL: /api/v1/game/:game_id

#### Response

The response will be a JSON object with the following structure:

```
{
    "game": {
        "id": "LANE-1",
        "current_player_name": "Miguel",
        "current_turn": 1,
        "next_player_names": [],
        "players": [
            {
                "name": "Miguel",
                "frame_scores": [],
                "frames": [[3]],
                "total_score": 0
            }
        ]
    }
}
```