extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var game_state_controller = get_node("/root/GameStateController")
onready var plot_name = self.get_name()
onready var ysort = get_node("/root/World/YSort")
onready var clock = get_node("/root/World/Clock")
onready var plant = Sprite.new()

var plot = {}
var plant_dict = {
	"cocoabean": "res://World/Garden/Plants/CocoaBeanTree-Sheet.png",
	"icecube": "res://World/Garden/Plants/IceCubeTree-Sheet.png",
	"vanillabean": "res://World/Garden/Plants/VanillaBeanTree-Sheet.png"
	}

# Called when the node enters the scene tree for the first time.
func _ready():
	var garden = game_state_controller.get_data("garden")
	if garden.has(plot_name):
		plot = garden[plot_name]
	else:
		plot = {
			"plant": "empty",
			"days_grown": 0,
			"water": false,
			"day_last_watered": 0,
		}
		game_state_controller.update_data("garden", plot_name, plot)
	ysort.add_child(plant)
	plant.set_hframes(3)
	plant.set_position(self.get_position())
		
		
func _process(delta):
	if not plot["plant"] == "empty":
		plant.set_texture(load(plant_dict[plot["plant"]]))
		if plot["water"] == true and plot["day_last_watered"] == clock.get_day():
			self.set_frame(1)
		elif plot["water"] == true and (clock.get_day() - plot["day_last_watered"]) == 1:
			plot["water"] = false
			plot["days_grown"] += 1
			plant.set_frame(plot["days_grown"])
			set_plot_data(plot)
			self.set_frame(0)
	else:
		plant.set_texture(null)
		plant.set_frame(0)
			
		
func get_plot_data():
	return plot

func set_plot_data(new_plot):
	plot = new_plot
	game_state_controller.update_data('garden',plot_name,plot)
	
func get_plot_name():
	return plot_name

func get_plant():
	return plant
