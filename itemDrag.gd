extends TextureRect

var dragging = false
var drag_offset = Vector2.ZERO
var original_position = Vector2.ZERO

func _ready():
	original_position = position
	mouse_filter = 1

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1:  # 1 is left click
			if event.pressed and get_global_rect().has_point(get_global_mouse_position()):
				dragging = true
				drag_offset = get_global_mouse_position() - global_position
				grab_focus()
				get_viewport().set_input_as_handled()
			elif not event.pressed and dragging:
				dragging = false
				check_drop()
	elif event is InputEventMouseMotion and dragging:
		global_position = get_global_mouse_position() - drag_offset

func check_drop():
	var spots = get_tree().get_nodes_in_group("spots")
	for spot in spots:
		if spot.get_global_rect().has_point(get_global_mouse_position()):
			#if spot.name == name.replace("Item", "Spot"):
				global_position = spot.global_position
				print("Placed on spot: ", spot.name)
				return
			#else:
				#print("Wrong spot for ", name)
	position = original_position
