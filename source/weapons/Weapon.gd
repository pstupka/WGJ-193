extends Node2D

onready var crosshair = $Crosshair
var bullet = preload("res://source/weapons/Bullet.tscn")

export var impulse : float = 1000
var can_fire = false

func _ready():
	set_process(false)


func _process(delta):
	var mouse_position = get_global_mouse_position()
	crosshair.look_at(mouse_position)
	if (crosshair.global_position.x - mouse_position.x < 0):
		crosshair.scale.y = 1
	else:
		crosshair.scale.y = -1


func fire_bullet():
	if can_fire:
		var bullet_instance : RigidBody2D = bullet.instance()
		var direction = global_position.direction_to(get_global_mouse_position()).normalized()
		bullet_instance.position = $Crosshair/Sprite.global_position
		bullet_instance.apply_central_impulse(direction * impulse)
		get_parent().get_parent().add_child(bullet_instance)
	can_fire = false
