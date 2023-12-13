# Super TicTacToe
Super tic-tac-toe is a game composed of nine tic-tac-toe boards arranged in a 3 × 3 grid. Players take turns playing on the smaller tic-tac-toe boards until one of them wins on the larger board.

## Rules
1. The two players (X and O) take turns, starting with X. The game starts with X playing wherever they want in any of the 81 empty spots.
2. Next the opponent plays, however they are forced to play in the small board indicated by the relative location of the previous move. For example, if X plays in the top right square of a small (3 × 3) board, then O has to play in the small board located at the top right of the larger board. Playing any of the available spots decides in which small board the next player plays.
3. If a move is played so that it is to win a small board by the rules of normal tic-tac-toe, then the entire small board is marked as won by the player in the larger board.
4. Once a small board is won by a player or it is filled completely, no more moves may be played on that board. If a player is sent to such a board, then that player may play on any other board.
5. Game ends when either a player wins the larger board or there are no legal moves remaining, in which case the game is a draw.

## Set up project

1. Open the project in Godot v4(v4.2 is recomended).
2. Click "Project" -> "Install Android Build Template". It'll create "./android/build" folder
3. Copy "./android/AndroidManifest.xml" file to "./android/build/AndroidManifest.xml" with replacing the file
