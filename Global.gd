extends Node

var SelectedCharacterTex

class CurrentChatBox:
	var item_name
	var item_tex_path
	
	func _init(one, two):
		item_name = one
		item_tex_path = two
	

var TexArray : Array[CurrentChatBox] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initialize_speech();
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func initialize_speech() -> void:
	TexArray.append(CurrentChatBox.new("Print of oat milk carton", load("res://assets/Hint_1_oat_milk.png")))
	TexArray.append(CurrentChatBox.new("Balloon animal pot", load("res://assets/hints/hint_2_animal_balloon.png")))
	TexArray.append(CurrentChatBox.new("Old cup", load("res://assets/hints/Hint_3_goblet.png")))
	TexArray.append(CurrentChatBox.new("Rabbit lantern", load("res://assets/hints/Hint_4_rabbit_lamp.png")))
	TexArray.append(CurrentChatBox.new("Hotdog toaster", load("res://assets/hints/Hint_5_hotdog.png")))
	TexArray.append(CurrentChatBox.new("Zombie plush", load("res://assets/hints/Hint_6_zombie.png")))
	TexArray.append(CurrentChatBox.new("Bread-shaped box", load("res://assets/hints/Hint_7_bread.png")))
	TexArray.append(CurrentChatBox.new("Singing fish", load("res://assets/hints/hint_8_fish.png")))
	TexArray.append(CurrentChatBox.new("Swan pot", load("res://assets/hints/hint_9_swan.png")))
	TexArray.append(CurrentChatBox.new("Shoe paper weight", load("res://assets/hints/Hint_10_shoe.png")))
	pass
