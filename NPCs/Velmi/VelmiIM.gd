extends InteractionManager

# Declare member variables here. Examples:
# var a = 2
# var b = "text
onready var dialog_player = get_node("/root/World/Dialog_Player")
onready var clock = get_node("/root/World/Clock")

var dialog = ""

func _process(delta):
	dialog = "velmi_day_" + String(clock.get_day())
# Called when the node enters the scene tree for the first time.
func receive_interaction() -> void:
	dialog_player.play_dialog(dialog)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
