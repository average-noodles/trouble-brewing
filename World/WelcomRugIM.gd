extends InteractionManager

onready var backyard_camera = get_node("/root/World/BackyardCamera2D")
onready var player = get_node("/root/World/YSort/Player")
onready var clock = get_node("/root/World/Clock")

func receive_interaction() -> void:
	player.set_position(Vector2(58,280))
	backyard_camera.make_current()
	
