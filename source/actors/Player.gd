extends KinematicBody2D

var SPEED = 80
var GRAVITY = 1000
var JUMP_SPEED = 300
var velocity = Vector2()

export (float, 0, 1.0) var FRICTION = 0.9
export (float, 0, 1.0) var ACCELERATION = 0.25

var SNAP_DIRECTION = Vector2.DOWN
var SNAP_LENGTH = 32
var MAX_SLOPE_ANGLE = 60

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var snap_vector = SNAP_DIRECTION * SNAP_LENGTH
	
	var direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			snap_vector = Vector2(0,0)
			velocity.y -= JUMP_SPEED
	
	velocity.y += GRAVITY * delta

	if direction != 0:

		velocity.x = lerp(velocity.x, direction * SPEED, ACCELERATION)
	else:
		velocity.x = 0
	

	velocity = move_and_slide(velocity,  Vector2.UP, true, 4, deg2rad(MAX_SLOPE_ANGLE))


