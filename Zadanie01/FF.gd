extends KinematicBody2D


const UP = Vector2(0, -1)
const GRAVITY = 20
const SPEED = 300
const JUMP_HEIGHT = -600
var motion = Vector2()
var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	

func _physics_process(delta):
	motion.y += GRAVITY
	
	if Input.is_action_pressed("ui_right"):
		motion.x = SPEED
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("walk")
	elif Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("walk")
	else:
		$AnimatedSprite.play("stand")
		motion.x = 0
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
			
	
	motion = move_and_slide(motion, UP)
	
	pass

func _process(delta):
	position += motion * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

