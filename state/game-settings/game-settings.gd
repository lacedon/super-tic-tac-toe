extends Node
class_name GameSettings

const cellNumber: int = 3
const cellNumberForLine: int = 3

enum GameMode {
	vsAI,
	hotSeat,
}

var mode: GameMode = GameMode.vsAI
var aiDificulty: String = 'rando'
var debug: bool = true
