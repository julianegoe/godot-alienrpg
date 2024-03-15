class_name GameTypes extends Node

signal game_mode_changed(mode)

enum GameTime {
	DAWN,
	DAY,
	DUSK,
	NIGHT,
}

enum Status { HEALTH, ENERGY }
enum Levels { A1, A2, A3 }
enum Directions { NORTH, EAST, SOUTH, WEST }
