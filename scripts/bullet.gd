extends Area2D

const SPEED = 600.0
const BULLET_DAMAGE = 25

var shotByPlayerOne: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_deferred("monitoring", false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += Vector2.RIGHT.rotated(rotation) * SPEED * delta


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		var player = body as Player
		if player.is_player_1 != shotByPlayerOne:
			player.gotHit(BULLET_DAMAGE)
	else if body is TileMap and body.get_collision_layer() & collision_mask:
		print("Hit tile layer:", body.get_collision_layer())
	else:
		print(body)
	hide()
	set_deferred("monitoring", false)
	set_physics_process(false)
	$AnimatedSprite2D.stop()
	
	
func reset() -> void:
	show()
	set_deferred("monitoring", true)
	set_physics_process(true)
	$AnimatedSprite2D.play()
