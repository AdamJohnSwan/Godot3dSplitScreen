extends Spatial

var player_scene = preload("res://Player.tscn")

func _ready():
	var player_count = 2
	var vbox = VBoxContainer.new()
	var top = null
	var bottom = null
	if player_count > 2:
		top = HBoxContainer.new()
		bottom = HBoxContainer.new()
		bottom.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		bottom.size_flags_vertical = Control.SIZE_EXPAND_FILL
	else:
		top = VBoxContainer.new()
	top.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	top.size_flags_vertical = Control.SIZE_EXPAND_FILL
	vbox.anchor_right = 1.0
	vbox.anchor_bottom = 1.0
	add_child(vbox)
	for i in range(player_count):
		var viewport_container = ViewportContainer.new()
		
		var viewport = Viewport.new()
		var player = player_scene.instance()
		player.player_number = i

		viewport.add_child(player)
		viewport_container.add_child(viewport)

		if i < 2:
			top.add_child(viewport_container)
		else:
			bottom.add_child(viewport_container)

		viewport_container.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		viewport_container.size_flags_vertical = Control.SIZE_EXPAND_FILL
		viewport_container.stretch = true
		viewport.handle_input_locally = false
		viewport.render_target_update_mode = 0
		
	if top != null:
		vbox.add_child(top)
	if bottom != null:
		vbox.add_child(bottom)
	pass
	

