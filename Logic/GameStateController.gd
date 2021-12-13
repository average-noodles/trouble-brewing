extends Node

onready var datetime = OS.get_datetime()

var path = "user://data.json"

var default_data = {
	"player": {
		"name": "default",
		"money": 1000,
		"cocoabean": 1,
		"vanillabean": 1,
		"icecube": 0,
		
	},
	"date_started" : {},
	"garden": {},
	"system_name" : {
		"username": ""
	},
	"game_state": {
		"glitched": false
	},
	"npcs": {
		"Betsy": {
			"time": {
				"in_time": 0,
				"out_time": 100000
			},
			"final_animation": "IdleRight",
			"file_location": "res://NPCs/Betsy/Betsy.tscn",
			"npc_path": "NPCsPath/BetsyPath2D/PathFollow2D",
			"ysort_path": "/root/World/YSort/BetsyKinematicBody2D",
			"days_in_shop": [1,2,3,4,5,6,7,8,10,12,14],
			"interaction": {
				"interacted_today": false,
				"last_interacted": 0,
				"total_interactions": 1,
				"max_interactions": 11,
			},
			"outcome":{}
		},
		"Malcolm": {
			"time": {
				"in_time": 0,
				"out_time": 100000
			},
			"final_animation": "IdleLeft",
			"file_location": "res://NPCs/Malcolm/Malcolm.tscn",
			"npc_path": "NPCsPath/MalcolmPath2D/PathFollow2D",
			"ysort_path": "/root/World/YSort/MalcolmKinematicBody2D",
			"days_in_shop": [1,2,3,4,5,6,7,8,9,10,11,12,13,14],
			"interaction": {
				"interacted_today": false,
				"last_interacted": 0,
				"total_interactions": 1,
				"max_interactions": 8,
			},
			"outcome": {}
		},
#		"Morton": {
#			"time": {
#				"in_time": 0,
#				"out_time": 100000
#			},
#			"final_animation": "IdleDown",
#			"file_location": "res://NPCs/Morton/Morton.tscn",
#			"npc_path": "NPCsPath/MortonPath2D/PathFollow2D",
#			"ysort_path": "/root/World/YSort/MortonKinematicBody2D",
#			"days_in_shop": [1,2,3,4,5,6,7,8,9,10,11,12,13,14],
#			"interaction": {
#				"interacted_today": false,
#				"last_interacted": 1,
#				"total_interactions": 1
#			}
#		},
		"Salesman": {
			"time": {
				"in_time": 0,
				"out_time": 120
			},
			"final_animation": "Idle",
			"file_location": "res://NPCs/Salesman/Salesman.tscn",
			"npc_path": "NPCsPath/SalesmanPath2D/PathFollow2D",
			"ysort_path": "/root/World/YSort/SalesmanKinematicBody2D",
			"days_in_shop": [7],
			"interaction": {
				"interacted_today": false,
				"last_interacted": 0,
				"total_interactions": 1,
				"max_interactions": 1,
			},
			"outcome": {}
		},
		"Crow": {
			"time": {
				"in_time": 0,
				"out_time": 100000
			},
			"final_animation": "IdleDown",
			"file_location": "res://NPCs/Crow/Crow.tscn",
			"npc_path": "NPCsPath/CrowPath2D/PathFollow2D",
			"ysort_path": "/root/World/YSort/CrowKinematicBody2D",
			"days_in_shop": [1,2,3,4,5,6,7,8,9,10,11,12,13,14],
			"interaction": {
				"interacted_today": false,
				"last_interacted": 0,
				"total_interactions": 1,
				"max_interactions": 14,
			},
			"outcome":{}
		},
		"Velmi": {
			"time": {
				"in_time": 0,
				"out_time": 1000000
			},
			"final_animation": "IdleLeft",
			"file_location": "res://NPCs/Velmi/Velmi.tscn",
			"npc_path": "NPCsPath/VelmiPath2D/PathFollow2D",
			"ysort_path": "/root/World/YSort/VelmiKinematicBody2D",
			"days_in_shop": [1,2,3,4,5,6,7,8,9,10,11,12,13,14],
			"interaction": {
				"interacted_today": false,
				"last_interacted": 0,
				"total_interactions": 1,
				"max_interactions": 14,
			},
			"outcome":{},
		},
		"Put": {
			"time": {
				"in_time": 0,
				"out_time": 1000000
			},
			"final_animation": "IdleDown",
			"file_location": "res://NPCs/Put/Put.tscn",
			"npc_path": "NPCsPath/PutPath2D/PathFollow2D",
			"ysort_path": "/root/World/YSort/PutKinematicBody2D",
			"days_in_shop": [1,2,3,4,5,6,7,9,11,13],
			"interaction": {
				"interacted_today": false,
				"last_interacted": 0,
				"total_interactions": 1,
				"max_interactions": 10,
			},
			"outcome":{},
		},
		"Sunni": {
			"time": {
				"in_time": 0,
				"out_time": 1000000
			},
			"final_animation": "IdleLeft",
			"file_location": "res://NPCs/Sunni/Sunni.tscn",
			"npc_path": "NPCsPath/SunniPath2D/PathFollow2D",
			"ysort_path": "/root/World/YSort/SunniKinematicBody2D",
			"days_in_shop": [1,2,3,4,5,6,7,8,9,10,11,12,13,14],
			"interaction": {
				"interacted_today": false,
				"last_interacted": 0,
				"total_interactions": 1,
				"max_interactions": 13,
			},
			"outcome":{}
		},
		"Watcher": {
			"time": {
				"in_time": 0,
				"out_time": 240
			},
			"final_animation": "Float",
			"file_location": "res://NPCs/Watcher/Watcher.tscn",
			"npc_path": "NPCsPath/WatcherPath2D/PathFollow2D",
			"ysort_path": "/root/World/YSort/WatcherKinematicBody2D",
			"days_in_shop": [1,3,5,7,9,11,13],
			"interaction": {
				"interacted_today": false,
				"last_interacted": 0,
				"total_interactions": 1,
				"max_interactions": 0,
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
	data["date_started"] = {
		"day": datetime.day,
		"month": datetime.month,
		"year": datetime.year
	}
	if OS.has_environment("USERNAME"):
		data["system_name"]["username"] = OS.get_environment("USERNAME")
	
	
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
