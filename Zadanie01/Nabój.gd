extends KinematicBody2D

var _gravity = 0

var _movement = Vector2()

func shoot(directional_force, gravity):
	_movement = directional_force
	_gravity = gravity
	set_physics_process(true)

func _physics_process(delta):
	_movement.y += delta * _gravity
	
	move_and_collide(_movement)
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
