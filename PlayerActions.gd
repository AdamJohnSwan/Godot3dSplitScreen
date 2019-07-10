extends Node

const action = [
["movement_forward_player_one", "movement_backward_player_one", "movement_left_player_one", "movement_right_player_one", "menu_player_one"],
["movement_forward_player_two", "movement_backward_player_two", "movement_left_player_two", "movement_right_player_two", "menu_player_two"],
]

var player

var forward
var backward
var left
var right
var menu

func set_actions(player_obj, player_number):
	forward = action[player_number][0]
	backward = action[player_number][1]
	left = action[player_number][2]
	right = action[player_number][3]
	menu = action[player_number][4]
	
	player = player_obj

func process_input(delta):
	
	player.dir = Vector3()
	var cam_xform = player.camera.get_global_transform()
	
	var input_movement_vector = Vector2()
	if Input.is_action_pressed(forward):
		input_movement_vector.y += 1
	if Input.is_action_pressed(backward):
		input_movement_vector.y -= 1
	if Input.is_action_pressed(left):
		input_movement_vector.x -= 1
	if Input.is_action_pressed(right):
		input_movement_vector.x += 1
	
	input_movement_vector = input_movement_vector.normalized()
	
	player.dir += -cam_xform.basis.z.normalized() * input_movement_vector.y
	player.dir += cam_xform.basis.x.normalized() * input_movement_vector.x
	
	if Input.is_action_just_pressed(menu):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)