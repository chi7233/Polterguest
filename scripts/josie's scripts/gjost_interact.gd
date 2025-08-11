extends Sprite2D


 




var base_pos=300;
var time_duration = 0.0;
var items = {}
var min_distance = 70
var text
var dragged_item 
var the_spot
@onready var text_content : Label = $Label
 


class ItemClass :
	var Name : String = ""
	var Placement : String = ""
	var HintText :String = ""
	# Constructor
	func _init(name: String = "", placement: String = "", hint_text: String = ""):
		Name = name
		Placement = placement
		HintText = hint_text
		
	static func create(name: String, placement: String, hint_text: String) -> ItemClass:
		return ItemClass.new(name, placement, hint_text)	
		
	
	
var ListOfItems : Array[ItemClass] = []



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
#	another_obj = load("res://check_box.gd").new()
	var base_pos = self.position.y
	var item_container = $"../CanvasLayer/ItemBar/TextureRect"
	text = $TextBox
	if (item_container != null):
		items =  item_container.get_children()
	else :
		print("nullptr")
	
	if (text):
		print("valid")	
	else:
		print ("not valid")
	text.visible = false; 
	
	the_spot = $"../script_node_scrore"
	
	load_csv_as_array("res://csv/polterguest_items.csv")
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_duration += delta
	self.position.y = base_pos + sin(time_duration * 5) * 30
	
	if(!items || items.size() == 0):
		print(":sob:")

	for item in items:
	
		if item.global_position.distance_to(self.global_position) < min_distance:
			match item.name:
				"HBoxContainer1", "HBoxContainer2", "HBoxContainer3", "HBoxContainer4", "HBoxContainer5", "HBoxContainer6", "HBoxContainer7", "HBoxContainer8", "HBoxContainer9", "HBoxContainer10", "HBoxContainer11", "HBoxContainer12", "HBoxContainer13", "HBoxContainer14":
					dragged_item = item
					print(dragged_item)
					if(item.get_child_count() > 0) :
						print("uyes")
						var item_name = item.get_node("Item/Label")
						for x in ListOfItems:
							if(item_name.text != x.Name):
								continue
							elif item_name.text == x.Name:
								text.visible = true
								text.get_node("MarginContainer/MarginContainer/Control/HBoxContainer/Label").text = x.HintText
							else:
								text.visible = 1; 
								#text.get_node("MarginContiner/MarginContainer/HBoxContainer/Label").text = "pulling my haor out"
						
						
					break 
		

	pass



func _input(event) -> void:
		
		var text_content : String = ""
		if (event.is_action_released("get_hint")) : #and is holding item
			if text.visible == true :
				text.visible = false
			#if dragged_item:
			#	print(dragged_item.get_node("Label").text)
			#	for spot in the_spot.spotList:
			#		if dragged_item.global_position.distance_to(spot.pos) < min_distance:
			#			spot._item_held = dragged_item.get_node("Label").text
			#			break
					
				
			
			
pass

func load_csv_as_array(csv_path :String) -> void:
	
	
	var file = FileAccess.open(csv_path, FileAccess.READ)
	
	if (!file):
		printerr("CSV File was not loaded: ", csv_path)
		pass
	
	while (!file.eof_reached()) :
		var line = file.get_line()
		if line == "":
			continue  # skip blank lines
		var columns = line.split(",")
	
		if columns.size() >= 3:
			var id = columns[0]
			var name = columns[1]
			var hint = columns[2]
			var item = ItemClass.new(id, name, hint)
			ListOfItems.append(item)
		else :
			ListOfItems.append(ItemClass.new())
	
	
	file.close()
	pass
