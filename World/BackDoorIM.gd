extends InteractionManager

onready var store_camera = get_node("/root/World/StoreCamera2D")
onready var player = get_node("/root/World/YSort/Player")
onready var clock = get_node("/root/World/Clock")

func receive_interaction() -> void:
	player.set_position(Vector2(58,148))
	store_camera.make_current()
