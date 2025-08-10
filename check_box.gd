extends RefCounted

class_name z


signal item_held_changed(new_item)  # ✅ Declare first!

var pos : Vector2
var spot_name : String
var item_needed : String
var item_held : String = ""

@export var _item_held : String:
	get:
		return item_held
	set(new_string):
		if item_held != new_string:
			item_held = new_string
			print(">> Setter assigning:", new_string)
			emit_signal("item_held_changed", new_string)  # ✅ Emitting signal

func _on_item_held_changed(new_item):
	print(">> Signal received:", new_item)
	if new_item == item_needed:
		print("correct ✅")

func _is_in_spot() -> bool:
	return (item_needed == item_held)

func _init(x: String, pos_vec: Vector2) -> void:
	spot_name = x
	pos = pos_vec
	connect("item_held_changed", self._on_item_held_changed)  # ✅ Signal connection

	match x:
		"Spot1":
			item_needed = "Print of oat milk carton"
		"Spot2":
			item_needed = "Old cup"
		"Spot3":
			item_needed = "Shoe paper weight"
		"Spot4":
			item_needed = "Balloon animal pot"
		"Spot5":
			item_needed = "Swan Pot"
		"Spot6":
			item_needed = "Zombie plush"
		"Spot7":
			item_needed = "Hotdog Toaster"
		"Spot8":
			item_needed = "Bread-shaped box"
		"Spot9":
			item_needed = "Singing fish"
		"Spot10":
			item_needed = "Rabbit lantern"

func as_string() -> String:
	return "[Item Name=%s, Placement=%s, Held=%s]" % [spot_name, item_needed, item_held]
