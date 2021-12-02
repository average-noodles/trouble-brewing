extends Node


var path = "user://data.json"

var default_data = {
	"player": {
		"name": "default",
		"money": 1000,
	},
	"date_started" : [1,1,2020],
	"garden": {}
}

var data = {}

func load_game():
	var file = File.new()
	
	if not file.file_exists(path):
		return false
	
	file.open(path,file.READ)
	
	var text = file.get_as_text()
	
	data = parse_json(text)
	
	file.close()
	
	return true
	
func save_game():
	var file
	
	file = File.new()
	
	file.open(path, File.WRITE)
	
	file.store_line(to_json(data))
	
	file.close()
	
func reset_data():
	data = default_data.duplicate(true)
	
func get_data(key):
	if data.has(key):
		return data[key]
	else:
		for dict_key in data:
			if data[dict_key].has(key):
				return data[dict_key][key]

func set_data(key,new_data):
	data[key] = new_data

func update_data(top_key, bottom_key, new_data):
	data[top_key][bottom_key] = new_data

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
