extends Node

var wind_strength = 10
var gravity = 100

var main_level = preload("res://source/levels/TestLevel.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.connect("new_game", self, "_on_new_game_started")


func _on_new_game_started() -> void:
	get_tree().change_scene_to(main_level)


