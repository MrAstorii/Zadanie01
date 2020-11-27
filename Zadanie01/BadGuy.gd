extends KinematicBody2D

onready var enemy = get_parent().get_node("FF")

var enemy_in_range
var enemy_in_sight
var can_fire = true
var speed = 120
var fire_direction
var enemy_position

var state = "Rest"

func _process(delta):
	match state:
		"Rest":
			print("Zzzzzzzz")
		"Attack":
			if can_fire == true:
				Attack()
			else:
				pass
			

func Attack():
	can_fire = false
	speed = 0
	
	get_node("TurnAxis").rotation = get_angle_to(enemy_position)
	var granade = load("res://Bullet.tscn")
	var granade_instance = granade.instance()
	
	granade_instance.position = get_node("TurnAxis/CastPoint").get_global_position()
	granade_instance.rotation = get_angle_to(enemy_position)
	
	get_parent().add_child(granade_instance)
	yield(get_tree().create_timer(0.6), "timeout")
	can_fire = true
	speed = 120


func _physics_process(delta):
	SightCheck()

func _on_Sight_body_entered(body):
	if body == enemy:
		enemy_in_range = true


func _on_Sight_body_exited(body):
	if body == enemy:
		enemy_in_range = false

func SightCheck():
	if enemy_in_range == true:
		var space_state = get_world_2d().direct_space_state
		var sight_check = space_state.intersect_ray(position, enemy.position, [self], collision_mask)
		if sight_check:
			if sight_check.collider.name == "FF":
				enemy_in_sight = true
				enemy_position =enemy.get_global_position()
				state = "Attack"
			else:
				enemy_in_sight = false
				state = "Rest"
	if enemy_in_range == false:
		state = "Rest"
