extends TextureRect

var dragging = false
var drag_offset = Vector2.ZERO
var original_position = Vector2.ZERO
var original_parent = null
var original_index = 0

func _ready():
	original_position = position
	mouse_filter = Control.MOUSE_FILTER_PASS

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed and get_global_rect().has_point(get_global_mouse_position()):
				start_drag()
			elif not event.pressed and dragging:
				end_drag()
	elif event is InputEventMouseMotion and dragging:
		global_position = get_global_mouse_position() - drag_offset

func start_drag():
	dragging = true
	drag_offset = get_global_mouse_position() - global_position
	grab_focus()
	get_viewport().set_input_as_handled()

	# 🪄 Save original parent and index
	original_parent = get_parent()
	original_index = original_parent.get_children().find(self)

	# 🪄 Move to CanvasLayer
	var drag_layer = get_tree().get_root().get_node("DragLayer")
	drag_layer.add_child(self)
	global_position = get_global_mouse_position() - drag_offset

func end_drag():
	dragging = false
	check_drop()

func check_drop():
	var spots = get_tree().get_nodes_in_group("spots")
	for spot in spots:
		if spot.get_global_rect().has_point(get_global_mouse_position()):
			global_position = spot.global_position
			print("Placed on spot: ", spot.name)
			return

	# 🧹 Return to original parent
	original_parent.add_child(self)
	original_parent.move_child(self, original_index)
	position = original_position
