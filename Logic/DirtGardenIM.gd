extends InteractionManager

onready var dirt_garden = get_parent()
onready var clock = get_node("/root/World/Clock")
onready var garden_menu = get_node("/root/World/GardenMenu")
onready var game_state_controller = get_node("/root/GameStateController")

func receive_interaction() -> void:
	var plot = dirt_garden.get_plot_data().duplicate(true)
	if plot["plant"] == "empty":
		garden_menu.display_menu(dirt_garden.get_plot_name())
	elif plot["days_grown"] >= 2:
		game_state_controller.update_data("player",plot["plant"],game_state_controller.get_data("player")[plot["plant"]] + 1)
		plot["day_last_water"] = 0
		plot["plant"] = "empty"
		plot["days_grown"] = 0
		dirt_garden.set_plot_data(plot)
	elif not plot["water"]:
		plot["water"] = true
		plot["day_last_watered"] = clock.get_day()
		dirt_garden.set_plot_data(plot)
		
		
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
