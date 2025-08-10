extends Node2D





# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"Ghost Select/choices/Left Portrait".pressed.connect(on_left_potrait_pressed)
	$"Ghost Select/choices/Middle Portrait".pressed.connect(on_middle_portrait_pressed)
	$"Ghost Select/choices/Right Portrait".pressed.connect(on_right_pressed)
	$"Continue Button".pressed.connect(on_continue)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_left_potrait_pressed():
	Global.SelectedCharacterTex = load("res://assets/mc_ghosts/mcghostii.png")
pass

func on_middle_portrait_pressed():
	Global.SelectedCharacterTex = load("res://assets/mc_ghosts/mcghostiii.png")
	pass

func on_right_pressed():
	Global.SelectedCharacterTex = load("res://assets/mc_ghosts/mcghost.png")
	pass

func on_continue():
	get_tree().change_scene_to_file("res://scenes/game.tscn")
pass
