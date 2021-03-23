extends Node2D


var explosion : PackedScene = preload("res://source/environment/Explosion.tscn")

#onready var test_ground = $TestGround

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var init_poly = Polygon2D.new()
	init_poly.set_polygon($initPolygon.polygon)
	$initPolygon.queue_free()
	var clipable_body = ClipableStaticBody.new(init_poly)
	var texture = ImageTexture.new()
	texture.load("res://icon.png")
	clipable_body.set_texture(texture)
	add_child(clipable_body)


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			var node_array : PoolVector2Array = []
			var explosion_instance = explosion.instance()
			explosion_instance.position = get_global_mouse_position()
			add_child(explosion_instance)
			for node in explosion_instance.explosion_polygon.polygon:
				node_array.append(node + get_global_mouse_position())
				
			print(get_tree().get_nodes_in_group("Clipable").size())
			for clippable in get_tree().get_nodes_in_group("Clipable"):
				var leftovers : Array = clippable.clip_static_body(node_array)
				for area in leftovers:
					var polygon = Polygon2D.new()
					polygon.set_polygon(area)
					var body = ClipableStaticBody.new(polygon)
					var texture = ImageTexture.new()
					texture.load("res://icon.png")
					body.set_texture(texture)
					add_child(body)

