extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var clock = get_node("/root/World/Clock")
onready var game_state_controller = get_node("/root/GameStateController")

func _on_pause_button_pressed():
	get_tree().paused = true
	$CanvasLayer/WindowDialog.show()
	
	
func _on_pause_popup_close_pressed():
	$CanvasLayer/WindowDialog.hide()
	get_tree().paused = false

func _on_enter_button_pressed():
	get_tree().paused = false
	clock.set_day(int($CanvasLayer/WindowDialog/LineEdit.text))
	$CanvasLayer/WindowDialog/LineEdit.clear()
	$CanvasLayer/WindowDialog.hide()
	game_state_controller.update_data("game_state","glitched", true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game_state_controller.get_data("Salesman")["outcome"].has("Salesman_interaction"):
		if game_state_controller.get_data("Salesman")["outcome"]["Salesman_interaction"] == "0":
			if Input.is_action_just_pressed("ui_debug") and get_tree().paused == false:
				_on_pause_button_pressed()
			elif Input.is_action_just_pressed("ui_debug") and get_tree().paused == true:
				_on_pause_popup_close_pressed()
			elif Input.is_action_just_pressed("ui_accept") and get_tree().paused == true:
				_on_enter_button_pressed()
