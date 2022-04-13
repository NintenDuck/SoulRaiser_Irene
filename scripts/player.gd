extends KinematicBody2D


onready var sprite = $Sprite
onready var animation = $AnimationPlayer

export var friction = 0.0
export var floor_friction = 0.0
export var air_friction = 0.0
export var vel_max = 0
export var acceleration = 0
export var jumpforce = 0
export var cut_height = 0.0

const UP = Vector2.UP
export var GRAVITY = 0

var motion = Vector2.ZERO
var direction = 0


func _ready():
	pass


func _physics_process(delta):
	check_direction()
	movement()
	update_animations()
	check_jump()
	

func check_direction() -> void:
	direction = int( Input.is_action_pressed( "k_right" ) ) - int( Input.is_action_pressed( "k_left" ) )


func movement() -> void:
	# Check user input to get current direction

	# 0 = neutral
	# 1 = right
	# 3 = left
	if direction == 0:
		if not is_on_floor():
			friction = air_friction
		else:
			friction = floor_friction
			
		motion.x = lerp( motion.x, 0, friction )

	motion.x += direction * acceleration
	motion.x = clamp( motion.x, -vel_max, vel_max )
	motion.y += GRAVITY

	motion = move_and_slide(motion,UP)


func _input(event):
	if event.is_action_released("k_jump_action"):
		if motion.y < 0:
			motion.y *= cut_height


func check_jump() -> void:
	if is_on_floor():
		if Input.is_action_just_pressed("k_jump_action"):
			jump(jumpforce)


func jump(force:float) -> void:
	motion.y -= force


func update_animations() -> void:
	if direction != 0:
		sprite.scale.x = direction
		if is_on_floor():
			animation.play("walk")
	else:
		if is_on_floor():
			animation.play("idle")
	if not is_on_floor():
		if motion.y > 70:
			animation.play("fall")
		else:
			animation.play("jump")
