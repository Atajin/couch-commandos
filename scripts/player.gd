class_name Player

extends CharacterBody2D


const SPEED = 200.0
const DEADZONE = 0.2

@export var player1_spriteframes: SpriteFrames
@export var player2_spriteframes: SpriteFrames
@export var is_player_1: bool = true

@onready var aim_pivot = $Pivot
@onready var barrel_tip = $Pivot/BarrelTip
@onready var bullet_pool = $"../BulletPool"

var is_reloading: bool = false

func _ready() -> void:
	if is_player_1:
		$Pivot/PlayerSprite.sprite_frames = player1_spriteframes
	else:
		$Pivot/PlayerSprite.sprite_frames = player2_spriteframes

func _process(delta: float) -> void:
	if is_player_1:
		if Input.is_action_just_pressed("reload_p1"):
			reload()
		if Input.is_action_just_pressed("shoot_p1"):
			shoot()
	else:
		if Input.is_action_just_pressed("reload_p2"):
			reload()
		if Input.is_action_just_pressed("shoot_p2"):
			shoot()
		
		
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
	
	
func shoot() -> void:
	if is_reloading: return
	if is_player_1:
		if globals.player1_pistol_ammo  == 0: return
		globals.player1_pistol_ammo -= 1
	else:
		if globals.player2_pistol_ammo == 0: return
		globals.player2_pistol_ammo -= 1
	var bullet = bullet_pool.get_bullet()
	if bullet:
		bullet.reset()
		bullet.shotByPlayerOne = true if is_player_1 else false
		bullet.global_position = barrel_tip.global_position
		bullet.rotation = barrel_tip.global_rotation


func reload() -> void:
	is_reloading = true
	$ReloadTimer.start()


func gotHit(damage) -> void:
	if is_player_1:
		globals.player1_health = max(0, globals.player1_health - damage)
	else:
		globals.player2_health = max(0, globals.player2_health - damage)


func _on_reload_timer_timeout() -> void:
	is_reloading = false
	if is_player_1:
		globals.player1_pistol_ammo = globals.MAX_PISTOL_AMMO
	else:
		globals.player2_pistol_ammo = globals.MAX_PISTOL_AMMO
