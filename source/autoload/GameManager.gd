extends Node

var wind_strength = 10
var gravity = 100

var main_level = preload("res://source/levels/TestLevel.tscn")
var color_palette = [
	Color("e4a672"),
	Color("b86f50"),
	Color("743f39"),
#	Color("3f2832"),
	Color("9e2835"),
	Color("e53b44"),
	Color("fb922b"),
	Color("ffe762"),
	Color("63c64d"),
	Color("327345"),
	Color("193d3f"),
	Color("4f6781"),
	Color("afbfd2"),
	Color("ffffff"),
	Color("2ce8f4"),
	Color("0484d1")
]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.connect("new_game", self, "_on_new_game_started")


func _on_new_game_started() -> void:
	get_tree().change_scene_to(main_level)


