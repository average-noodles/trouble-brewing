extends PathFollow2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var animation_player = get_node("VelmiKinematicBody2D/AnimationPlayer")
onready var door = get_node("/root/World/MainEnterance")
export var runSpeed = 20
var enter = false
var exit = false

func _process(delta):
	if enter:
		if get_unit_offset() < 0.78:
			play_animation("RunUp")
		elif get_unit_offset() >= 0.78 and get_unit_offset() < 0.91:
			play_animation("RunLeft")
			if door.get_active():
				door.play_animation()
		elif get_unit_offset() >= 0.90 and get_unit_offset() < 1.00:
			play_animation("RunUp")
		else:
			play_animation("RunLeft")
		var newOffset = get_offset() + runSpeed * delta
		set_offset(newOffset)
			
		if get_unit_offset() == 1:
			enter = false
			play_animation("IdleLeft")
	if exit:
		if get_unit_offset() < 0.78:
			play_animation("RunDown")
		elif get_unit_offset() >= 0.78 and get_unit_offset() < 0.91:
			play_animation("RunRight")
			if door.get_active():
				door.play_animation()
		elif get_unit_offset() >= 0.90 and get_unit_offset() < 1.00:
			play_animation("RunDown")
		var newOffset = get_offset() - runSpeed * delta
		set_offset(newOffset)
		if get_unit_offset() == 0:
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
