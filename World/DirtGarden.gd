extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var game_state_controller = get_node("/root/GameStateController")
onready var plot_name = self.get_name() + "_plot"
onready var clock = get_node("/root/World/Clock")

var plot = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	var garden = game_state_controller.get_data("garden")
	if garden.has(plot_name):
		plot = garden[plot_name]
	else:
		plot = {
			"plant": "empty",
			"day_planted": 0,
			"water": false,
			"day_last_watered": 0
		}
		game_state_controller.update_data("garden", plot_name, plot)
		
func _process(delta):
	if plot["water"] == true and plot["day_last_watered"] == clock.get_day():
		self.set_frame(1)
	else:
		plot["water"] = false
		set_plot_data(plot)
		self.set_frame(0)

func get_plot_data():
	return plot

func set_plot_data(new_plot):
	plot = new_plot
	game_state_controller.update_data('garden',plot_name,plot)
	
func get_plot_name():
	return plot_name


