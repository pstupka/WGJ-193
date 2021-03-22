extends Node2D


onready var explosion_polygon = $ExplosionPolygon


# Called when the node enters the scene tree for the first time.
func _ready():
	$Particles.emitting = true
	yield(get_tree().create_timer(1),"timeout")
	queue_free()

