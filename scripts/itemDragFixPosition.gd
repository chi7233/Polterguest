extends TextureRect

var dragging = false
var drag_offset = Vector2.ZERO
var original_position = Vector2.ZERO
var locked = false  # 是否锁定，锁定后禁止拖拽

func _ready():
	original_position = position
	mouse_filter = 1

func _gui_input(event):
	if locked:
		return  # 锁定后不响应任何拖拽相关事件

	if event is InputEventMouseButton:
		if event.button_index == 1:
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
			global_position = spot.global_position
			print("Placed on spot: ", spot.name)
			locked = true  # 放到spot后锁定，不再可拖
			return

	# 没放到spot，恢复原位
	position = original_position
