extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_start_game_button_down():
	get_tree().change_scene_to_file("res://ui_health.tscn")

func _on_option_button_down():
	print("options opened")


func _on_quit_button_down():
	get_tree().quit()
