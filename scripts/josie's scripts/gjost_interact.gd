extends Sprite2D


var base_pos=300;
var time_duration = 0.0;
var items = {}
var min_distance = 100
var text


func create_textbox()->void:
	
	pass



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var base_pos = self.position.y
	var item_container = $"../CanvasLayer/ItemArea/HBoxContainer"
	text = $"../TextBox"
	if (item_container != null):
		items =  item_container.get_children()
	else :
		print("nullptr")	
	text.visible = false; 
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_duration += delta
	self.position.y = base_pos + sin(time_duration * 5) * 30
	for x in items : 
		if (x.position == self.position) :
			print("item is overlapping with ghost")
	pass


func _input(event) -> void:
		var cases; 
		if (event.is_action_released("get_hint")) : #and is holding item
			if text.visible == true :
				text.visible = false
			if (items[0].dragging && items[0].global_position.distance_to(self.global_position) < min_distance) :
				text.visible = true
			
pass
