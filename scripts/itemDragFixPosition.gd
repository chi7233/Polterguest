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
	
	
func returnPath(x) ->String:
	
	match x:
		"Item1":
			return "res://assets/hints/Hint_1_oat_milk.png"
		"Item2":
			return "res://assets/hints/hint_2_animal_balloon.png"
		"Item3":
			return "res://assets/hints/Hint_3_goblet.png"
		"Item4":
			return "res://assets/hints/Hint_4_rabbit_lamp.png"
		"Item5":
			return "res://assets/hints/Hint_5_hotdog.png"
		"Item6":
			return "res://assets/hints/Hint_6_zombie.png"
		"Item7":
			return "res://assets/hints/Hint_7_bread.png"
		"Item8":
			return "res://assets/hints/hint_8_fish.png"
		"Item9":
			return "res://assets/hints/hint_9_swan.png"
		"Item10":	
			return "res://assets/hints/Hint_10_shoe.png"
	return x

func _on_mouse_entered() -> void:
	$"../../../../../Sprite2D/TextBox".visible = true
	$"../../../../../Sprite2D/TextBox/MarginContainer2".texture = load(returnPath(self.name))
	print(self.name)
pass # Replace with function body.


func _on_mouse_exited() -> void:
	$"../../../../../Sprite2D/TextBox".visible = false
	pass # Replace with function body.
