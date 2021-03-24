extends KinematicBody2D
class_name Player


# Movement section
export var SPEED = 80
export var GRAVITY = 500
export var JUMP_SPEED = 230
var velocity = Vector2()
var direction = 0.0
var can_move = false

export (float, 0, 1.0) var FRICTION = 0.9
export (float, 0, 1.0) var ACCELERATION = 0.25

var MAX_SLOPE_ANGLE = 60

# Camera section
var camera_initial_zoom
onready var camera2d = $Camera2D
onready var tweenCameraZoom = $Camera2D/TweenCameraZoom

# Animation Player
onready var animation_player = $AnimationPlayer

onready var weapon = $Weapon
onready var tween = $Tween

export var MAX_HEALTH = 200
var current_health = MAX_HEALTH

# Player settings
var player_color : Color
var player_name : String

var id : String

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Players")
	player_color = GameManager.global_settings[id + "_color"]
	$Pivot/Sprite.modulate = player_color
	
	player_name = GameManager.global_settings[id + "_name"]
	if player_name == "":
		$NameLabel.text = "Player"
	else:
		$NameLabel.text = player_name
	
	camera_initial_zoom = camera2d.zoom
	animation_player.play("player_animation_idle")
	weapon.hide()


func _process(delta: float) -> void:
	pass


func _physics_process(delta):
	if can_move:
		process_input(delta)
	process_movement(delta)
	handle_animation_state()


func _unhandled_key_input(event):
	if event.is_action_pressed("camera_zoom_out"):
		tweenCameraZoom.interpolate_property($Camera2D,
			"zoom",
			camera_initial_zoom,
			2.5 * camera_initial_zoom,
			0.6,
			Tween.TRANS_EXPO,
			Tween.EASE_OUT
		)
		tweenCameraZoom.start()
	if event.is_action_released("camera_zoom_out"):
		tweenCameraZoom.interpolate_property($Camera2D,
			"zoom",
			$Camera2D.zoom,
			camera_initial_zoom,
			0.6,
			Tween.TRANS_EXPO,
			Tween.EASE_OUT
		)
		tweenCameraZoom.start()


func process_input(_delta):
	direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y -= JUMP_SPEED
			
	if Input.is_action_just_pressed("fire"):
		$Weapon.load_weapon()
#		$Weapon.fire_bullet()
	if Input.is_action_just_released("fire"):
		$Weapon.interrupt_loading()


func process_movement(delta):
	velocity.y += GRAVITY * delta

	if direction != 0:
		velocity.x = lerp(velocity.x, direction * SPEED, ACCELERATION)
	else:
		velocity.x = 0
	
	velocity = move_and_slide(velocity, Vector2.UP, true, 4, deg2rad(MAX_SLOPE_ANGLE))


func handle_animation_state() -> void:
	if direction != 0:
		animation_player.play("player_animation_run")
	if velocity.y > 0 and direction == 0:
		$Pivot.rotation_degrees = 0
		animation_player.stop()
		animation_player.play("player_animation_still")
		return
	if direction == 0:
		$Pivot.rotation_degrees = 0
		animation_player.play("player_animation_idle")


func end_turn() -> void:
	can_move = false
	weapon.can_fire = false
	weapon.set_process(false)
	weapon.hide()
	direction = 0
	animation_player.play("player_animation_idle")
	camera2d.current = false


func start_turn() -> void:
	can_move = true
	weapon.can_fire = true
	weapon.set_process(true)
	weapon.show()
	
	camera2d.current = true


func _on_Hitbox_area_entered(area):
	if area.is_in_group("Explosions"):
		print(global_position.distance_to(area.global_position))
