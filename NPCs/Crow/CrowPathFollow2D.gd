extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var animation_player = get_node("AnimationPlayer")
onready var door = get_node("/root/World/MainEnterance")
onready var path_2d = get_node("/root/World/NPCsPath/CrowPath2D/PathFollow2D")
export var runSpeed = 20
var enter = false
var exit = false

func _process(delta):
	if enter:
		if path_2d.get_unit_offset() < 0.3384:
			play_animation("RunDown")
		elif path_2d.get_unit_offset() >= 0.3384 and path_2d.get_unit_offset() < 0.9598:
			play_animation("RunLeft")
			if door.get_active():
				door.play_animation()
		elif path_2d.get_unit_offset() >= 0.5000 and path_2d.get_unit_offset() < 0.9598:
			play_animation("RunLeft")
		else:
			play_animation("RunDown")
		var newOffset = path_2d.get_offset() + runSpeed * delta
		path_2d.set_offset(newOffset)
			
		if path_2d.get_unit_offset() == 1:
			enter = false
			play_animation("IdleDown")
	if exit:
		if path_2d.get_unit_offset() < 0.3384:
			play_animation("RunUp")
		elif path_2d.get_unit_offset() >= 0.3384 and path_2d.get_unit_offset() < 0.5000:
			play_animation("RunRight")
			if door.get_active():
				door.play_animation()
		elif path_2d.get_unit_offset() >= 0.5000 and path_2d.get_unit_offset() < 0.9598:
			play_animation("RunRight")
		else:
			play_animation("RunUp")
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
