extends KinematicBody2D

export var SPEED = 80
export var GRAVITY = 1000
export var JUMP_SPEED = 300
var velocity = Vector2()
var direction = 0.0
var can_move = false

export (float, 0, 1.0) var FRICTION = 0.9
export (float, 0, 1.0) var ACCELERATION = 0.25

var MAX_SLOPE_ANGLE = 60

var team : String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if can_move:
		process_input(delta)
	process_movement(delta)


func process_input(delta):
	direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y -= JUMP_SPEED



func process_movement(delta):
	velocity.y += GRAVITY * delta

	if direction != 0:
		velocity.x = lerp(velocity.x, direction * SPEED, ACCELERATION)
	else:
		velocity.x = 0
	
	velocity = move_and_slide(velocity, Vector2.UP, true, 4, deg2rad(MAX_SLOPE_ANGLE))
