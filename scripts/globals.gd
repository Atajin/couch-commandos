extends Node

signal player_ammo_changed(new_value)

const MAX_PISTOL_AMMO: int = 9

var hud: Node = null
var player1_health: int = 100
var player2_health: int = 100
var player1_pistol_ammo: int = MAX_PISTOL_AMMO:
	set(value):
		player1_pistol_ammo = value
		player_ammo_changed.emit(value, true)
var player2_pistol_ammo: int = MAX_PISTOL_AMMO:
	set(value):
		player2_pistol_ammo = value
		player_ammo_changed.emit(value, false)
