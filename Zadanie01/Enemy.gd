extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const SPEED = 300
const JUMP_HEIGHT = -600
var motion = Vector2()
var screen_size

var granade = preload("res://Granade.tscn")
var can_fire = true
var rate_of_fire = 0.4


func _process(delta):
	SkillLoop()

func SkillLoop():
	if Input.is_action_pressed("shoot") and can_fire == true:
		can_fire = false
		get_node("TurnAxis").rotation = get_angle_to(get_global_mouse_position())
		var granade_instance = granade.instance()
		granade_instance.position = get_node("TurnAxis/CastPoint").get_global_position()
		granade_instance.rotation = get_angle_to(get_global_mouse_position())
		get_parent().add_child(granade_instance)
		yield(get_tree().create_timer(rate_of_fire), "timeout")
		can_fire = true

func _physics_process(delta):
	motion.y += GRAVITY
	
	
	if Input.is_action_pressed("ui_right"):
		motion.x = SPEED
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("be")
	elif Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("be")
	else:
		$AnimatedSprite.play("be")
		motion.x = 0
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
			
	
	motion = move_and_slide(motion, UP)
	
	pass


func _on_Area2D_body_entered(body):
	hide()
	$CollisionShape2D.set_deferred("disabled", true)
