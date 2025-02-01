extends ProgressBar
	
var health_bar: int = 100
var max_health: int = 100
	

# Called when the node enters the scene tree for the first time.
func _ready():
	value = health_bar
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_bbc(10)
	print(health_bar)
	value = health_bar
	
	if health_bar == 0:
		get_tree().change_scene_to_file("res://Main_Node.tscn")
		
	
	
func _bbc(dmg : int):#fonction pour les dmg
	
	health_bar -= dmg
	health_bar = clamp(health_bar,0,max_health)
	
