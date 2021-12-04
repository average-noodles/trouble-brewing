extends InteractionManager

# Declare member variables here. Examples:
# var a = 2
# var b = "text
onready var dialog_player = get_node("/root/World/Dialog_Player")
onready var clock = get_node("/root/World/Clock")
onready var game_state_controller = get_node("/root/GameStateController")

var dialog = ""
var interaction_dict = {}
var npc_dict = {}
var npc_name = "Crow"

func _ready():
	npc_dict = game_state_controller.get_data(npc_name)
	interaction_dict = game_state_controller.get_data(npc_name)["interaction"]
 
func _process(delta):
	if interaction_dict["last_interacted"] != clock.get_day():
		interaction_dict["interacted_today"] = false
		npc_dict["interaction"] = interaction_dict
		game_state_controller.update_data("npcs",npc_name,npc_dict)
	dialog = npc_name + "_interaction_" + String(interaction_dict["total_interactions"])
# Called when the node enters the scene tree for the first time.
func receive_interaction() -> void:
	if not interaction_dict["interacted_today"]:
		dialog_player.play_dialog(dialog)
		interaction_dict["interacted_today"] = true
		interaction_dict["last_interacted"] = clock.get_day()
		interaction_dict["total_interactions"] += 1
		npc_dict["interaction"] = interaction_dict
		game_state_controller.update_data("npcs",npc_name,npc_dict)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
