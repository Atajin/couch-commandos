extends Area2D

const SPEED = 600.0
const BULLET_DAMAGE = 25

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += Vector2.RIGHT.rotated(rotation) * SPEED * delta


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		var player = body as Player
		player.gotHit(BULLET_DAMAGE)
	hide()
	set_physics_process(false)
	$AnimatedSprite2D.stop()
	
	
func reset() -> void:
	show()
	set_physics_process(true)
	$AnimatedSprite2D.play()
