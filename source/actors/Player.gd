extends KinematicBody2D

var speed = 100
var gravity = 200
var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	velocity.x = direction * speed
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)


