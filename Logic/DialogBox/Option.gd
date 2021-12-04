extends NinePatchRect

signal clicked(slot)

onready var button = get_node("Button")

var slot

func _on_Button_pressed():
	emit_signal("clicked", slot)

func set_text(new_text):
	button.set_text(new_text)
