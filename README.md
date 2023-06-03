# Bowling game

## Main Requirements

The API should be written in Elixir (or, if you prefer, Ruby). All the technical
details are your call as soon as it provides the following actions:

- Start a new bowling game.
- Input the number of pins knocked down by each ball thrown.
- Output the current game score (including each frame's and total scores).

> Imagine that a bowling house will use this API. On the screen, the user starts the
> game. Then after each throw, the machine counts how many pins are down and calls
> the API, sending this information. The screen is constantly (i.e. every 2 seconds)
> querying the API for the game score and displaying it.

## Game details

- Bowling is played by throwing a ball down an alley towards ten wooden pins.
- The game is played in ten frames. At the beginning of each frame, all ten pins
are set up. The player then gets two tries to knock them all down.
- If the player knocks all the pins down on the first try, it is called a
"strike", and the frame ends.
- If the player fails to knock down all the pins with his first ball but succeeds
with the second ball, it is called a "spare".
- After the second ball of the frame, the frame ends even if any number of pins
are still standing.
- A "strike" frame is scored by adding ten plus the number of pins knocked down
by the following two balls to the score of the previous frame.
- A "spare" frame is scored by adding ten plus the number of pins knocked down by
the next ball to the score of the previous frame.
- Otherwise, a frame is scored by adding the number of pins knocked down by the
two balls in the frame to the score of the previous frame.
- If a "strike" is thrown in the tenth frame, then the player may throw two more
balls to complete the score of the "strike".
- Likewise, if a "spare" is thrown in the tenth frame, the player may throw one
more ball to complete the score of the "spare".
- Therefore, the tenth frame may have three balls instead of two.

For more information, please see https://en.wikipedia.org/wiki/Ten-pin_bowling

## What do we expect?

- We expect code to be working, readable, logical, and covered with tests.
- Ideally, a ready solution should be available to us via git (it would be nice
if we have the commit history) with instructions on how to run it.
- There's no need to provide anything other than what is requested in the task
(but if you want to do so, it's ok too).
- We don't expect you to spend more than 4 hours on this task. It means you can
stop doing this challenge if you think it took too long and write in plain text
what you would do if you had the proper time.
- If you'll spend more time than what we expect you to do, it's ok to code just a
tiny part of the challenge. In that case, we would value these parts more, in
the giving order: 1) Score calculation, 2) Game state, and 3) API.
