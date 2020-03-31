# app_academy_ghost
Ruby implementation of a famous road-trip word game, [Ghost](https://en.wikipedia.org/wiki/Ghost_(game)). The game is multiplayer, with the ability to choose any number of human or AI players.

# How the AI works:
* If adding a letter to the fragment would spell a word, then the letter is a losing move.
* If adding a letter to the fragment would leave only words with n (number of other players) or fewer additional letters as possibilities, then the letter is a winning move.
* The AI takes any available winning move; if none is available, randomly selects a losing move.
