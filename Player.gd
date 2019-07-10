extends KinematicBody

const GRAVITY = -35.8
const MAX_SPEED = 35
const ACCEL = 4.5
const DEACCEL = 16
const MAX_SLOP_ANGLE = 40

var camera
var player_number = 0

var PlayerActions = load("res://PlayerActions.gd")

var player_actions
var dir = Vector3()
var vel = Vector3()

func _ready():
	camera = $Camera
	player_actions = PlayerActions.new()
	player_actions.set_actions(self, player_number)
	var spawns = get_node("/root/Arena/SpawnPoints")
	var spawn = spawns.get_children()[player_number]
	if spawn != null:
			var position = spawn.global_transform.origin
			global_transform.origin = position

func _physics_process(delta):
	player_actions.process_input(delta)
	process_movement(delta)

func process_movement(delta):
	dir.y = 0
	dir = dir.normalized()
	
	vel.y += delta * GRAVITY
	
	var hvel = vel
	hvel.y = 0
	
	var target = dir
	target *= MAX_SPEED
	
	var accel
	if dir.dot(hvel) > 0:
		accel = ACCEL
	else:
		accel = DEACCEL
		
	hvel = hvel.linear_interpolate(target, accel * delta)
	vel.x = hvel.x
	vel.z = hvel.z
	vel = move_and_slide(vel, Vector3(0, 1, 0), 0.05, 4, deg2rad(MAX_SLOP_ANGLE))