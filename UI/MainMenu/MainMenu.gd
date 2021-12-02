extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var animation_player = get_node("LogoTextureRect/SmokeSprite/AnimationPlayer")
onready var load_button = get_node("LoadButton")
onready var new_game_button = get_node("NewGameButton")
onready var delete_save_popup_menu = get_node("DeleteSavePopupMenu")
onready var game_state_controller = get_node("/root/GameStateController")
onready var no_save_game_popup = get_node("NoSaveGamePopup")

var path = "user://data.json"
var data = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("SmokeMove")

func _on_LoadButton_pressed():
	if game_state_controller.load_game():
		get_tree().change_scene("res://World/World.tscn")
	else:
		load_button.hide()
		new_game_button.hide()
		no_save_game_popup.show()

func _on_NewGameButton_pressed():
	load_button.hide()
	new_game_button.hide()
	delete_save_popup_menu.show()

func _on_YesButton_pressed():
	game_state_controller.reset_data()
	game_state_controller.save_game()
	get_tree().change_scene("res://World/World.tscn")


func _on_NoButton_pressed():
	load_button.show()
	new_game_button.show()
	delete_save_popup_menu.hide()
	
func _on_OkButton_pressed():
	load_button.show()
	new_game_button.show()
	no_save_game_popup.hide()
	
	
