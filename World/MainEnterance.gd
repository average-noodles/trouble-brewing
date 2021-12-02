extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func play_animation():
	$AnimationPlayer.play("OpenDoor")

func get_active():
	return $AnimationPlayer.is_active()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
