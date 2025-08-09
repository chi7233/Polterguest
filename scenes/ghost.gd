extends Sprite2D


var base_pos=300;
var time_duration = 0.0;
var items = {}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var base_pos = self.position.y
	var item_container = $"../CanvasLayer/ItemArea/HBoxContainer"
	if (item_container != null):
		items =  item_container.get_children()
	else :
		print("nullptr")	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_duration += delta
	self.position.y = base_pos + sin(time_duration * 5) * 30
	pass


func _input(event) -> void:
	
	pass
