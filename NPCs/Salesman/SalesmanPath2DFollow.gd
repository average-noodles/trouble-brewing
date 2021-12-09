extends KinematicBody2D

onready var animation_player = get_node("AnimationPlayer")
onready var path_2d = get_node("/root/World/NPCsPath/SalesmanPath2D/PathFollow2D")
export var runSpeed = 20
var enter = false
var exit = false

func _process(delta):
	if enter:
		var newOffset = path_2d.get_offset() + runSpeed * delta
		path_2d.set_offset(newOffset)
			
		if path_2d.get_unit_offset() == 1:
			enter = false
			play_animation("Arrive")
	elif exit:
		play_animation("Depart")
		var newOffset = path_2d.get_offset() - runSpeed * delta
		path_2d.set_offset(newOffset)
		if path_2d.get_unit_offset() == 0:
			exit = false
			queue_free()
	else:
		play_animation("Idle")
		
func set_enter(bool_val):
	enter = bool_val
	
func set_exit(bool_val):	
	exit = bool_val
	
func play_animation(animation):
	animation_player.play(animation)




# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
