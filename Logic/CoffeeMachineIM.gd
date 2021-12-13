extends InteractionManager


onready var coffee_menu = get_node("/root/World/CoffeeMenu")


# Called when the node enters the scene tree for the first time.
func receive_interaction() -> void:
	coffee_menu.display_menu()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
