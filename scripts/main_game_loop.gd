extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	globals.player_health_changed.connect(_on_health_changed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func reset() -> void:
	pass


func _on_health_changed(new_value: int, is_player_one: bool) -> void:
	if new_value != 0: return
	globals.current_round += 1
	if is_player_one:
		globals.player1_score += 1
	else:
		globals.player2_score += 1
