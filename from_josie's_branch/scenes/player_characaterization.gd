extends Sprite2D

var GetTexture; 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.texture = Global.SelectedCharacterTex
	
	var target_width = 110
	var target_height = 160

	var tex_size = self.texture.get_size()
	self.scale = Vector2(
		target_width / tex_size.x,
		target_height / tex_size.y
	)
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
