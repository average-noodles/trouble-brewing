extends Control

var plot_name = ""
var plot = ""

func display_menu(new_plot_name):
	plot_name = new_plot_name
	$CanvasLayer/Popup.set_visible(true)
	get_tree().paused = true
	plot = get_node("/root/World/" + plot_name)

func plant(plant_type):
	var plot_data = plot.get_plot_data()
	plot_data["plant"] = plant_type
	plot.set_plot_data(plot_data)
	get_tree().paused = false
	$CanvasLayer/Popup.set_visible(false)

func _on_CocoaButton_pressed():
	plant("cocoabean")

func _on_VanillaButton_pressed():
	plant("vanillabean")

func _on_IceButton_pressed():
	plant("icecube")
