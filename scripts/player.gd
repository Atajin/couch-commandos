extends CharacterBody2D


const SPEED = 300.0
const DEADZONE = 0.2

@export var is_player_1: bool = true

@onready var aim_pivot = $Pivot

func _physics_process(delta: float) -> void:
	var input_vector = get_input_vector()
	
	if input_vector.length() > 0:
		velocity = input_vector * SPEED
		aim_pivot.rotation = input_vector.angle()
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)

	move_and_slide()

func get_input_vector() -> Vector2:
	if is_player_1:
		var keyboard_input = Vector2(
			Input.get_axis("move_left_p1", "move_right_p1"),
			Input.get_axis("move_up_p1", "move_down_p1")
		)
		if keyboard_input.length() > 0:
			return keyboard_input.normalized()
			
		var controller_input = Vector2(
			Input.get_joy_axis(0, JOY_AXIS_LEFT_X),
			Input.get_joy_axis(0, JOY_AXIS_LEFT_Y)
		)
		if controller_input.length() > DEADZONE:
			return controller_input.normalized()
	else:
		var keyboard_input = Vector2(
			Input.get_axis("ui_left", "ui_right"),
			Input.get_axis("ui_up", "ui_down")
		)
		if keyboard_input.length() > 0:
			return keyboard_input.normalized()
			
		var controller_input = Vector2(
			Input.get_joy_axis(1, JOY_AXIS_LEFT_X),
			Input.get_joy_axis(1, JOY_AXIS_LEFT_Y)
		)
		if controller_input.length() > DEADZONE:
			return controller_input.normalized()
	
	return Vector2.ZERO
