class_name Player

extends CharacterBody2D


const SPEED = 300.0
const DEADZONE = 0.2

@export var player1_spriteframes: SpriteFrames
@export var player2_spriteframes: SpriteFrames
@export var is_player_1: bool = true

@onready var aim_pivot = $Pivot
@onready var barrel_tip = $Pivot/BarrelTip
@onready var bullet_pool = $"../BulletPool"
@onready var reload_sound = $AudioStreamPlayer2D

var is_reloading: bool = false
var is_dead: bool = false

func _ready() -> void:
	if is_player_1:
		$Pivot/PlayerSprite.sprite_frames = player1_spriteframes
	else:
		$Pivot/PlayerSprite.sprite_frames = player2_spriteframes

func _process(delta: float) -> void:
	if !is_dead:
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
	if !is_dead:
		var input_vector = get_input_vector()
		
		if input_vector.length() > 0:
			velocity = input_vector * SPEED
			aim_pivot.rotation = input_vector.angle()
		else:
			velocity = velocity.move_toward(Vector2.ZERO, SPEED)

		var aim_vector = get_aim_vector()
		if aim_vector.length() > DEADZONE:
			aim_pivot.rotation = aim_vector.angle()

		move_and_slide()
	
	
func get_aim_vector() -> Vector2:
	if is_player_1:
		if Input.get_connected_joypads().size() > 0:
			var controller_aim = Vector2(
				Input.get_joy_axis(0, JOY_AXIS_RIGHT_X),
				Input.get_joy_axis(0, JOY_AXIS_RIGHT_Y)
			)
			if controller_aim.length() > DEADZONE:
				return controller_aim.normalized()
	else:
		if Input.get_connected_joypads().size() > 1:
			var controller_aim = Vector2(
				Input.get_joy_axis(1, JOY_AXIS_RIGHT_X),
				Input.get_joy_axis(1, JOY_AXIS_LEFT_Y)
			)
			if controller_aim.length() > DEADZONE:
				return controller_aim.normalized()
				
	return Vector2.ZERO

func get_input_vector() -> Vector2:
	if is_player_1:
		var keyboard_input = Vector2(
			Input.get_axis("move_left_p1", "move_right_p1"),
			Input.get_axis("move_up_p1", "move_down_p1")
		)
		
		if keyboard_input.length() > 0:
			return keyboard_input.normalized()
			
		# Only check controller 0 for player 1
		if Input.get_connected_joypads().size() > 0:
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
			
			
		if Input.get_connected_joypads().size() > 1:
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
		globals.player1_shots_fired += 1
	else:
		if globals.player2_pistol_ammo == 0: return
		globals.player2_pistol_ammo -= 1
		globals.player2_shots_fired += 1
	var bullet = bullet_pool.get_bullet()
	if bullet:
		bullet.reset()
		bullet.shotByPlayerOne = true if is_player_1 else false
		bullet.global_position = barrel_tip.global_position
		bullet.rotation = barrel_tip.global_rotation
		audio_manager.play_gunshot()


func reload() -> void:
	if !is_reloading:
		reload_sound.play()
		$Pivot/PlayerSprite.play("reload")
		is_reloading = true
		$ReloadTimer.start()


func gotHit(damage) -> void:
	if is_player_1:
		globals.player1_health = max(0, globals.player1_health - damage)
	else:
		globals.player2_health = max(0, globals.player2_health - damage)


func _on_reload_timer_timeout() -> void:
	$Pivot/PlayerSprite.play("default")
	is_reloading = false
	if is_player_1:
		globals.player1_pistol_ammo = globals.MAX_PISTOL_AMMO
	else:
		globals.player2_pistol_ammo = globals.MAX_PISTOL_AMMO
		
