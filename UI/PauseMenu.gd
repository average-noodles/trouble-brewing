extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var game_state_controller = get_node("/root/GameStateController")
# Called when the node enters the scene tree for the first time

func _on_pause_button_pressed():
	get_tree().paused = true
	$CanvasLayer/WindowDialog.show()
	
func _on_pause_popup_close_pressed():
	$CanvasLayer/WindowDialog.hide()
	get_tree().paused = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_pause") and get_tree().paused == false:
		_on_pause_button_pressed()
	elif Input.is_action_just_pressed("ui_pause") and get_tree().paused == true:
		_on_pause_popup_close_pressed()


func _on_SaveButton_pressed():
	game_state_controller.save_game()

func _on_SaveAndQuitButton_pressed():
	game_state_controller.save_game()
	get_tree().quit()

func _on_QuitButton_pressed():
	get_tree().quit()
