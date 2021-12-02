extends InteractionManager

onready var dirt_garden = get_parent()
onready var clock = get_node("/root/World/Clock")

func receive_interaction() -> void:
	var plot = dirt_garden.get_plot_data().duplicate(true)
	if not plot["water"]:
		plot["water"] = true
		plot["day_last_watered"] = clock.get_day()
		dirt_garden.set_plot_data(plot)
		
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
