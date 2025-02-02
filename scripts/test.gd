extends Node2D

@export var health_bar_node: ProgressBar  # Reference to the health bar

func _ready():
	test_health_bar()

# Must be a separate async function
func test_health_bar():
	health_bar_node._bbc(20)  # Apply 20 damage

	# Wait for 2 seconds before applying more damage
	await get_tree().create_timer(2).timeout  

	health_bar_node._bbc(30)  # Apply 30 more damage
