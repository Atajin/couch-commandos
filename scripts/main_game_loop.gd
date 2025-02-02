extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	globals.player_health_changed.connect(_on_health_changed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $RoundTimer.is_stopped() == false:
		$HUD/HBoxContainer3/Timer.text = "%d seconds" % [$RoundTimer.time_left]


func reset() -> void:
	$RoundTimer.stop()
	globals.current_round += 1
	if globals.current_round > globals.MAX_ROUNDS:
		finish_game()
	else:
		if (globals.current_round != globals.MAX_ROUNDS):
			$HUD/HBoxContainer3/Round.text = "Round: " + str(globals.current_round)
		else:
			$HUD/HBoxContainer3/Round.text = "Final Round"
		$Breakable.respawn_breakables()
		$Player1.position = $PlayerSpawn1.position
		$Player2.position = $PlayerSpawn2.position
		globals.player1_health = globals.MAX_PLAYER_HEALTH
		globals.player2_health = globals.MAX_PLAYER_HEALTH
		globals.player1_pistol_ammo = globals.MAX_PISTOL_AMMO
		globals.player2_pistol_ammo = globals.MAX_PISTOL_AMMO
		$RoundTimer.start()

func finish_game() -> void:
	get_tree().change_scene_to_file("res://menus/game_over.tscn")


func _on_health_changed(new_value: int, is_player_one: bool) -> void:
	$RoundTimer.stop()
	if new_value != 0: return
	$DeathTimer.start()
	if !is_player_one:
		$Player2/Pivot/PlayerSprite.play("dead")
		$Player2.is_dead = true
		globals.player1_score += 1
		$HUD/HBoxContainer4/PlayerName1.text = "Player 1     %s" % ["I".repeat(globals.player1_score)]
	else:
		$Player1/Pivot/PlayerSprite.play("dead")
		$Player1.is_dead = true
		globals.player2_score += 1
		$HUD/HBoxContainer4/PlayerName2.text = "Player 2     %s" % ["I".repeat(globals.player2_score)]
	print("1", globals.player1_score)
	print("2", globals.player1_score)


func _on_death_timer_timeout() -> void:
	$Player1/Pivot/PlayerSprite.play("default")
	$Player1.is_dead = false
	$Player2/Pivot/PlayerSprite.play("default")
	$Player2.is_dead = false
	reset()


func _on_round_timer_timeout() -> void:
	reset()
