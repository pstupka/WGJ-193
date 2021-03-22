extends StaticBody2D
class_name ClipableStaticBody

var polygon : Polygon2D setget set_polygon
var collision_polygon : CollisionPolygon2D


func _init(_polygon : Polygon2D):
	self.polygon = _polygon
	add_to_group("Clipable")

func _ready():
	add_child(polygon)
	add_child(collision_polygon)


func set_polygon(new_polygon : Polygon2D):
	if new_polygon == null:
		return
	polygon = new_polygon
	if collision_polygon == null:
		collision_polygon = CollisionPolygon2D.new()
	collision_polygon.set_polygon(polygon.polygon)


func clip_static_body(polygon_to_clip : PoolVector2Array) -> Array:
	var clipped_array = Geometry.clip_polygons_2d(polygon.polygon, polygon_to_clip)
	if clipped_array.size() > 1:
#		clipped_array.remove(1) 
		print(clipped_array.size())
	#TODO THIS
		
	polygon.set_polygon(clipped_array[0])
	collision_polygon.set_polygon(clipped_array[0])
	return clipped_array
