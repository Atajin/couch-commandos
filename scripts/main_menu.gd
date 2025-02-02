extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_up(button_name: String) -> void:
	if button_name == "map1":
		get_tree().change_scene_to_file("res://maps/map_1.tscn")
		
	if button_name == "map2":
		get_tree().change_scene_to_file("res://maps/map_2.tscn")

	if button_name == "options":
		print("Options opened!")

	if button_name == "quit":
		get_tree().quit()
