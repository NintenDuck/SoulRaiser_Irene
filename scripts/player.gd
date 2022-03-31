extends KinematicBody2D


export var friction = 0.0
export var vel_max = 0
export var acceleration = 0
export var jumpforce = 0


const UP = Vector2.UP
export var GRAVITY = 0


var motion = Vector2.ZERO
var direction = 0

func _ready():
	pass


func _physics_process(delta):
	movement()
	check_jump()


func movement():
	direction = int( Input.is_action_pressed( "k_right" ) ) - int( Input.is_action_pressed( "k_left" ) )
	
	motion.x += direction * acceleration

	if direction == 0:
		if is_on_floor():
			motion.x = lerp( motion.x, 0, friction )
	
	motion.x = clamp( motion.x, -vel_max, vel_max )
	motion.y += GRAVITY
	
	motion = move_and_slide(motion,UP)


func check_jump():
	if is_on_floor():
		if Input.is_action_just_pressed("k_jump_action"):
			print("Jumping!")
			jump(jumpforce)


func jump(force):
	motion.y -= force
