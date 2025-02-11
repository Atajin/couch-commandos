extends Node

signal player_ammo_changed(new_value, is_player_one)
signal player_health_changed(new_value, is_player_one)
signal player_score_changed(new_value, is_player_one)

const MAX_PLAYER_HEALTH: int = 100
const MAX_PISTOL_AMMO: int = 9
const MAX_ROUNDS: int = 5

var hud: Node = null
var current_map: String = ""
var current_round: int = 1
var player1_score: int = 0
var player2_score: int = 0
var player1_shots_fired: int = 0
var player2_shots_fired: int = 0
var player1_health: int = MAX_PLAYER_HEALTH:
	set(value):
		player1_health = value
		player_health_changed.emit(value, true)
var player2_health: int = MAX_PLAYER_HEALTH:
	set(value):
		player2_health = value
		player_health_changed.emit(value, false)
var player1_pistol_ammo: int = MAX_PISTOL_AMMO:
	set(value):
		player1_pistol_ammo = value
		player_ammo_changed.emit(value, true)
var player2_pistol_ammo: int = MAX_PISTOL_AMMO:
	set(value):
		player2_pistol_ammo = value
		player_ammo_changed.emit(value, false)
		
