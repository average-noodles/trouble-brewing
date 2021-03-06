extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var animation_player = get_node("AnimationPlayer")
onready var door = get_node("/root/World/MainEnterance")
onready var path_2d = get_node("/root/World/NPCsPath/MortonPath2D/PathFollow2D")
export var runSpeed = 20
var enter = false
var exit = false

func _process(delta):
	if enter:
		if path_2d.get_unit_offset() < 0.78:
			play_animation("RunUp")
		elif path_2d.get_unit_offset() >= 0.78 and path_2d.get_unit_offset() < 1:
			play_animation("RunLeft")
			if door.get_active():
				door.play_animation()
		else:
			play_animation("RunDown")
		var newOffset = path_2d.get_offset() + runSpeed * delta
		path_2d.set_offset(newOffset)
			
		if path_2d.get_unit_offset() == 1:
			enter = false
			play_animation("IdleRight")
	if exit:
		if path_2d.get_unit_offset() < 0.78:
			play_animation("RunDown")
		elif path_2d.get_unit_offset() >= 0.78 and path_2d.get_unit_offset() < 1:
			play_animation("RunRight")
			if door.get_active():
				door.play_animation()
		var newOffset = path_2d.get_offset() - runSpeed * delta
		path_2d.set_offset(newOffset)
		if path_2d.get_unit_offset() == 0:
			exit = false
			queue_free()

func set_enter(bool_val):
	enter = bool_val
	
func set_exit(bool_val):	
	exit = bool_val
	
func play_animation(animation):
	animation_player.play(animation)




# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
