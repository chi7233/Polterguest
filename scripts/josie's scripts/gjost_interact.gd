extends Sprite2D


var base_pos=300;
var time_duration = 0.0;
var items = {}
var min_distance = 100
var text
var dragged_item 
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
		
	func as_string() -> String:
		return "[Item Name=%s, Placemente=%s, Hint=%s]" % [Name, Placement, HintText]
	
var ListOfItems : Array[ItemClass] = []


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
	
	load_csv_as_array("res://csv/polterguest_items.csv")
	if (ListOfItems.size() > 0):
		print(ListOfItems)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_duration += delta
	self.position.y = base_pos + sin(time_duration * 5) * 30
	while (items.any(func(x): return x.global_position.distance_to(self.global_position) < min_distance )):
		dragged_item = items.find(func(x): 
				match x.name:
					"Item1":
						return x
					"Item3":
						return x
					"Item4":
						return x
					"Item5":
						return x
					"Item6":
						return x
					"Item7":
						return x
					"Item8":
						return x
					"Item9":
						return x
					"Item10":
						return x
					"Item11":
						return x
					"Item12":
						return x
					"Item13":
						return x
					"Item14":
						print("c")
					_:
						return null
				)

	if(dragged_item):
		print(dragged_item.name)
		
		

	pass


func _input(event) -> void:
		var cases; 
		var text_content : String = ""
		if (event.is_action_released("get_hint")) : #and is holding item
			if text.visible == true :
				text.visible = false
			if (items.any(func(x): return x.global_position.distance_to(self.global_position) < min_distance )):
				text.visible = true
				
				
			
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
