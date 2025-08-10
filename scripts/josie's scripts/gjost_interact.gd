extends Sprite2D


var base_pos=300;
var time_duration = 0.0;
var items = {}
var min_distance = 100
var text
var itemList : Array


func create_textbox()->void:
	
	pass



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var base_pos = self.position.y
	var item_container = $"../DragLayer/ItemBar/HBoxContainer"
	text = $"../TextBox"
	if (item_container != null):
		items =  item_container.get_children()
	else :
		print("nullptr")
	
	if (text):
		print("valid")	
	else:
		print ("not valid")
	text.visible = false; 
	
	itemList = load_csv_as_array("res://csv/polterguest_items.csv")
	if (itemList.size() > 0):
		print(itemList)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_duration += delta
	self.position.y = base_pos + sin(time_duration * 5) * 30
	for x in items : 
		if (items.any(func(x): return x.global_position.distance_to(self.global_position) < min_distance )):
			print("item is overlapping with ghost")
	pass


func _input(event) -> void:
		var cases; 
		if (event.is_action_released("get_hint")) : #and is holding item
			if text.visible == true :
				text.visible = false
			if (items.any(func(x): return x.global_position.distance_to(self.global_position) < min_distance )):
				text.visible = true
			
pass

func load_csv_as_array(csv_path :String) -> Array:
	
	var item_hints : Array = []; 
	
	var file = FileAccess.open(csv_path, FileAccess.READ)
	
	if (!file):
		printerr("CSV File was not loaded: ", csv_path)
		return []
	
	while (!file.eof_reached()) :
		item_hints.append( file.get_line().split(","))
		
		file.close()
	
	return item_hints
