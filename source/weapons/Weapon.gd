extends Node2D

onready var crosshair = $Crosshair


func _ready():
	pass


func _process(delta):
	var mouse_position = get_global_mouse_position()
	crosshair.look_at(mouse_position)
	if (crosshair.global_position.x - mouse_position.x < 0):
		crosshair.scale.y = 1
	else:
		crosshair.scale.y = -1
	
