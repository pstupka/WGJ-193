extends Node2D

onready var crosshair = $Crosshair
var bullet = preload("res://source/weapons/Bullet.tscn")

export var impulse : float = 500

func _ready():
	pass


func _process(delta):
	var mouse_position = get_global_mouse_position()
	crosshair.look_at(mouse_position)
	if (crosshair.global_position.x - mouse_position.x < 0):
		crosshair.scale.y = 1
	else:
		crosshair.scale.y = -1
	
func fire_bullet():
	var bullet_instance : RigidBody2D = bullet.instance()
	var direction = global_position.direction_to(get_global_mouse_position()).normalized()
	bullet_instance.position = $Crosshair/Sprite.global_position
	bullet_instance.apply_central_impulse(direction * impulse)
	get_parent().get_parent().add_child(bullet_instance)
	pass
