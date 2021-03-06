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
var npc_name = "Betsy"

func _ready():
	npc_dict = game_state_controller.get_data(npc_name)
	interaction_dict = game_state_controller.get_data(npc_name)["interaction"]
 
func _process(delta):
	if interaction_dict["last_interacted"] != clock.get_day():
		interaction_dict["interacted_today"] = false
		npc_dict["interaction"] = interaction_dict
		game_state_controller.update_data("npcs",npc_name,npc_dict)
	if game_state_controller.get_data("glitched"):
		dialog = "glitched_dialog"
	else:
		dialog = npc_name + "_interaction_" + String(interaction_dict["total_interactions"])
# Called when the node enters the scene tree for the first time.
func receive_interaction() -> void:
	if not interaction_dict["interacted_today"]:
		if interaction_dict["max_interactions"] >= interaction_dict["total_interactions"]:
			dialog_player.play_dialog(dialog,npc_name)
			interaction_dict["interacted_today"] = true
			interaction_dict["last_interacted"] = clock.get_day()
			interaction_dict["total_interactions"] += 1
			npc_dict["interaction"] = interaction_dict
			game_state_controller.update_data("npcs",npc_name,npc_dict)
		else:
			dialog_player.play_dialog("no_dialog_dialog",npc_name)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
