extends Node


var path = "user://data.json"

var default_data = {
	"player": {
		"name": "default",
		"money": 1000,
	},
	"date_started" : {
		"day": -1,
		"month": -1,
		"year": -1,
	},
	"garden": {},
	"npcs": {
#		"Betsy": {
#			"time": {
#				"in_time": 500,
#				"out_time": 100000
#			},
#			"final_animation": "IdleLeft",
#			"file_location": "res://NPCs/Velmi/Velmi.tscn",
#			"npc_path": "YSort/VelmiPath2D",
#			"interaction": {
#				"interacted_today": false,
#				"last_interacted": {
#					"day": -1,
#					"month": -1,
#					"year": -1,
#				},
#				"total_interactions": 0
#			},
#		},
		"Malcolm": {
			"time": {
				"in_time": 0,
				"out_time": 100000
			},
			"final_animation": "IdleLeft",
			"file_location": "res://NPCs/Malcolm/Malcolm.tscn",
			"npc_path": "NPCsPath/MalcolmPath2D/PathFollow2D",
			"ysort_path": "/root/World/YSort/MalcolmKinematicBody2D",
			"interaction": {
				"interacted_today": false,
				"last_interacted": 0,
				"total_interactions": 0
			}
		},
		"Morton": {
			"time": {
				"in_time": 109,
				"out_time": 100000
			},
			"final_animation": "IdleDown",
			"file_location": "res://NPCs/Morton/Morton.tscn",
			"npc_path": "NPCsPath/MortonPath2D/PathFollow2D",
			"ysort_path": "/root/World/YSort/MortonKinematicBody2D",
			"interaction": {
				"interacted_today": false,
				"last_interacted": 1,
				"total_interactions": 1
			}
		},
#		"Saleman": {
#			"time": {
#				"in_time": 500,
#				"out_time": 100000
#			},
#			"final_animation": "IdleLeft",
#			"file_location": "res://NPCs/Velmi/Velmi.tscn",
#			"npc_path": "YSort/VelmiPath2D",
#			"interaction": {
#				"interacted_today": false,
#				"last_interacted": {
#					"day": -1,
#					"month": -1,
#					"year": -1,
#				},
#				"total_interactions": 0
#			}
#		},
#		"Crow": {
#			"time": {
#				"in_time": 500,
#				"out_time": 100000
#			},
#			"final_animation": "IdleLeft",
#			"file_location": "res://NPCs/Velmi/Velmi.tscn",
#			"npc_path": "YSort/VelmiPath2D",
#			"interaction": {
#				"interacted_today": false,
#				"last_interacted": {
#					"day": -1,
#					"month": -1,
#					"year": -1,
#				},
#				"total_interactions": 0
#			}
#		},
		"Velmi": {
			"time": {
				"in_time": 0,
				"out_time": 1000000
			},
			"final_animation": "IdleLeft",
			"file_location": "res://NPCs/Velmi/Velmi.tscn",
			"npc_path": "NPCsPath/VelmiPath2D/PathFollow2D",
			"ysort_path": "/root/World/YSort/VelmiKinematicBody2D",
			"interaction": {
				"interacted_today": false,
				"last_interacted": 0,
				"total_interactions": 1
			},
		}
	}
		
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
