extends Control

onready var game_state_controller = get_node("/root/GameStateController")


func display_menu():
	$CanvasLayer/Popup.set_visible(true)
	get_tree().paused = true

func sell(plant_type):
	var player = game_state_controller.get_data("player")
	var plant_total = player[plant_type]
	if plant_total > 0:
		player[plant_type] -= 1
		player["money"] += 100
		game_state_controller.set_data("player",player)
	get_tree().paused = false
	$CanvasLayer/Popup.set_visible(false)

func _on_CocoaButton_pressed():
	sell("cocoabean")

func _on_VanillaButton_pressed():
	sell("vanillabean")

func _on_IceButton_pressed():
	sell("icecube")
