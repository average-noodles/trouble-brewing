extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var game_state_controller = get_node("/root/GameStateController")
# Called when the node enters the scene tree for the first time

func _on_pause_button_pressed():
	$CanvasLayer/Popup.show()
	
func _on_pause_popup_close_pressed():
	$CanvasLayer/Popup.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_inventory") and $CanvasLayer/Popup.visible == false:
		_on_pause_button_pressed()
	elif Input.is_action_just_pressed("ui_inventory") and $CanvasLayer/Popup.visible == true:
		_on_pause_popup_close_pressed()
	
	$CanvasLayer/Popup/TextureRect/MoneyLabel.set_text(String(game_state_controller.get_data("money")))
	$CanvasLayer/Popup/TextureRect/CocoaBeanLabel.set_text(String(game_state_controller.get_data("cocoabean")))
	$CanvasLayer/Popup/TextureRect/VanillaBeanLabel.set_text(String(game_state_controller.get_data("vanillabean")))
	$CanvasLayer/Popup/TextureRect/IceCubeLabel.set_text(String(game_state_controller.get_data("icecube")))

