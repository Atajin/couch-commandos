extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	globals.hud = self
	globals.player_ammo_changed.connect(_on_ammo_changed)
	globals.player_health_changed.connect(_on_health_changed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_ammo_changed(new_value: int, is_player_one: bool) -> void:
	if is_player_one:
		$"HBoxContainer/Control/BulletAmount".text = str(new_value) + "/9"
	else:
		$"HBoxContainer/Control2/BulletAmount".text = str(new_value) + "/9"

func _on_health_changed(new_value: int, is_player_one: bool) -> void:
	if is_player_one:
		$"HealthBar1".value = new_value
	else:
		$"HealthBar2".value = new_value
