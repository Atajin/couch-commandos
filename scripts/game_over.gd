extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if globals.player1_score > globals.player2_score:
		$Winner1.visible = true
		$Winner2.visible = false
		$Draw.visible = false
	elif globals.player1_score == globals.player2_score:
		$Winner1.visible = false
		$Winner2.visible = false
		$Draw.visible = true
	else:
		$Winner1.visible = false
		$Winner2.visible = true
		$Draw.visible = false
	$VBoxContainer/Round.text = "Rounds won: " + str(globals.player1_score)
	$VBoxContainer2/Round.text = "Rounds won: " + str(globals.player2_score)
	$VBoxContainer/Shots.text = "Shots fired: " + str(globals.player1_shots_fired)
	$VBoxContainer2/Shots.text = "Shots fired: " + str(globals.player2_shots_fired)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_up(button_name: String) -> void:
	globals.current_round = 1
	globals.player1_score = 0
	globals.player2_score = 0
	globals.player1_shots_fired = 0
	globals.player2_shots_fired = 0
	globals.player1_health = globals.MAX_PLAYER_HEALTH
	globals.player2_health = globals.MAX_PLAYER_HEALTH
	globals.player1_pistol_ammo = globals.MAX_PISTOL_AMMO
	globals.player2_pistol_ammo = globals.MAX_PISTOL_AMMO
	
	if button_name == "replay":
		get_tree().change_scene_to_file(str(globals.current_map))
	
	if button_name == "menu":
		get_tree().change_scene_to_file("res://menus/main_menu.tscn")
