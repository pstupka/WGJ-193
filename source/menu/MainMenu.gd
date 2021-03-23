extends Control


func _ready() -> void:
	register_buttons()


func register_buttons():
	var buttons = get_tree().get_nodes_in_group("ui_buttons")
	for button in buttons:
		button.connect("pressed", self, "_on_button_pressed", [button])


func _on_button_pressed(button) -> void:
	match button.name:
		"StartButton":
			print("StartButton pressed")
			Events.emit_signal("new_game")
		"CreditsButton":
			print("CreditsButton pressed")
		"AboutButton":
			print("AboutButton pressed")
		"Player1Left":
			print("Player1Left pressed")
		"Player1Right":
			print("Player1Right pressed")
		"Player2Left":
			print("Player2Left pressed")
		"Player2Right":
			print("Player2Right pressed")

