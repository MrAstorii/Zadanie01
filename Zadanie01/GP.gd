extends KinematicBody2D

export (float) var naboj_angle = 350 setget set_naboj_angle

export (int) var naboj_speed = 8


export (int) var naboj_gravity = 5

export (float) var naboj_delay = 1
var waited = 0


export (PackedScene) var bullet_scene

export (NodePath) var naboj_spawn_path
onready var naboj_spawn = get_node(naboj_spawn_path)

var directional_force = Vector2()

var shooting = false

func set_naboj_angle(value):
	naboj_angle = clamp(value, 0, 359)

func update_directional_force():
	directional_force = Vector2(cos(naboj_angle*(PI/180)), sin(naboj_angle*(PI/180)))

func _ready():
	update_directional_force()
	
	set_process_input(true)
	
	set_process(true)

func _input(event):
	if(event.is_action_pressed("ui_select")):
		shooting = true
	elif(event.is_action_pressed("ui_select")):
		shooting = false

func _process(delta):
	if(shooting && waited > naboj_delay):
		#fire_once()
		rapid_fire()
		waited = 0
	elif(waited <= naboj_delay):
		waited += delta


func fire_once():
	shoot()
	shooting = false

func rapid_fire():
	shoot()

func shoot():
	var bullet = bullet_scene.instance()
	bullet.set_global_position(naboj_spawn.get_global_position())
	bullet.shoot(directional_force, naboj_gravity)
	get_parent().add_child(bullet)
