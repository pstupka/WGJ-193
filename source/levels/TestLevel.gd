extends Node2D


var explosion : PackedScene = preload("res://source/environment/Explosion.tscn")
onready var test_ground = $TestGround
var test_area : StaticBody2D



# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			var node_array : PoolVector2Array = []
			var explosion_instance = explosion.instance()
			explosion_instance.position = get_global_mouse_position()
			add_child(explosion_instance)
			for node in explosion_instance.explosion_polygon.polygon:
				node_array.append(node + get_global_mouse_position())
			for clippable in get_tree().get_nodes_in_group("Clipable"):
				clippable.clip_static_body(node_array)

