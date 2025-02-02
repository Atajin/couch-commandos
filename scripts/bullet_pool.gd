extends Node2D

const POOL_SIZE = 20
var bullets: Array[Area2D] = []
var bullet_scene = preload("res://scenes/bullet.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in POOL_SIZE:
		var bullet = bullet_scene.instantiate()
		bullet.hide()
		add_child(bullet)
		bullets.push_back(bullet)
		
func get_bullet() -> Area2D:
	for bullet in bullets:
		if not bullet.visible:
			bullet.show()
			return bullet
	return null
