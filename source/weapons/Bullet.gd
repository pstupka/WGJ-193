extends RigidBody2D

export(PackedScene) var explosion

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _process(delta: float) -> void:
	$CollisionShape2D.rotation = linear_velocity.angle()
	$bullet.rotation = linear_velocity.angle()
	
	if position.y > 10000:
		queue_free()
	
	var colliders = get_colliding_bodies()
	for collider in colliders:
		if collider.is_in_group("Terrain"):
			var explosion_instance = explosion.instance()
			explosion_instance.global_position = global_position
			get_tree().current_scene.add_child(explosion_instance)
			Events.emit_signal("bullet_exploded", explosion_instance.explosion_polygon)
			queue_free()
