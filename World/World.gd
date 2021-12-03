extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var clock = get_node("Clock")
onready var game_state_controller = get_node(("/root/GameStateController"))
onready var player = get_node("YSort/Player")
onready var ysort = get_node("YSort")
onready var dialog_player = get_node("Dialog_Player")

var current_npcs = {}
var character_dictionary = {}
# Called when the node enters the scene tree for the first time.
func _ready():
	character_dictionary = game_state_controller.get_data("npcs")
	for key in character_dictionary:
		var time_range = character_dictionary[key]["time"]
		var time = clock.get_time()
		time = time[0] * 60 + time[1]
		if time_range["in_time"] <= time and time_range["out_time"] > time:
			var npc_instance = load(character_dictionary[key]["file_location"])
			var npc = npc_instance.instance()
			ysort.add_child(npc)
			var npc_path = get_node(character_dictionary[key]["npc_path"])
			var remote_transform = RemoteTransform2D.new()
			remote_transform.set_update_rotation(false)
			remote_transform.set_update_scale(false)
			remote_transform.set_remote_node(character_dictionary[key]["ysort_path"])
			npc_path.add_child(remote_transform)
			npc_path.set_unit_offset(1)
			npc.play_animation(character_dictionary[key]["final_animation"])
			current_npcs[key] = {"time": character_dictionary[key]["time"], "npc": npc}
			

func _process(delta):
	for key in current_npcs:
		var time_range = current_npcs[key]["time"]
		var time = clock.get_time()
		time = time[0] * 60 + time[1]
		if time_range["in_time"] > time or time_range["out_time"] <= time:
			current_npcs[key]["npc"].set_exit(true)
			current_npcs.erase(key)
			
	for key in character_dictionary:
		var time_range = character_dictionary[key]["time"]
		var time = clock.get_time()
		time = time[0] * 60 + time[1]
		if (time_range["in_time"] <= time and time_range["out_time"] > time) and not current_npcs.has(key):
			var npc_instance = load(character_dictionary[key]["file_location"])
			var npc = npc_instance.instance()
			ysort.add_child(npc)
			var npc_path = get_node(character_dictionary[key]["npc_path"])
			var remote_transform = RemoteTransform2D.new()
			remote_transform.set_update_rotation(false)
			remote_transform.set_update_scale(false)
			remote_transform.set_remote_node(character_dictionary[key]["ysort_path"])
			npc_path.add_child(remote_transform)
			npc_path.set_unit_offset(1)
			npc.set_enter(true)
			current_npcs[key] = {"time": character_dictionary[key]["time"], "npc": npc}	
	
	if dialog_player.get_dialog_box_visibility():
		player.set_free(false)
	else:
		player.set_free(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
