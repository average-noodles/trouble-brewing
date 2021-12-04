extends Node

onready var _Body_AnimationPlayer = self.find_node("Body_AnimationPlayer")
onready var _Body_LBL = self.find_node("Body_Label")
onready var _Dialog_Box = self.find_node("Dialog_Box")
onready var _Speaker_LBL = self.find_node("Speaker_Label")
onready var _SpaceBar_Icon = self.find_node("SpaceBar_NinePatchRect")
onready var game_state_controller = get_node("/root/GameStateController")
onready var option_list = get_node("CanvasLayer/Dialog_Box/Body_NinePatchRect/Option_List")
onready var select_choice = get_node("CanvasLayer/Dialog_Box/Body_NinePatchRect/Select_Choice")

onready var option_button_scene = load("res://Logic/DialogBox/Option.tscn")

var _did = 0
var _nid = 0
var _final_nid = 0
var _Story_Reader

# Virtual Methods

func _ready():
	var Story_Reader_Class = load("res://addons/EXP-System-Dialog/Reference_StoryReader/EXP_StoryReader.gd")
	_Story_Reader = Story_Reader_Class.new()
	
	var story = load("res://Logic/DialogBox/stories/MainStory_baked.tres")
	_Story_Reader.read(story)
	
	_Dialog_Box.visible = false
	_SpaceBar_Icon.visible = false
	select_choice.visible = false
	option_list.visible = false
	
	_clear_options()


func _input(event):
	if event is InputEventKey:
		if event.pressed == true and event.scancode == KEY_SPACE:
			_on_Dialog_Player_pressed_spacebar()

# Callback Methods

func _on_Body_AnimationPlayer_animation_finished(anim_name):
	if 	option_list.get_child_count() == 0:
		_SpaceBar_Icon.visible = true
	else:
		select_choice.visible = true
		option_list.visible = true


func _on_Dialog_Player_pressed_spacebar():
	if _is_waiting():
		_SpaceBar_Icon.visible = false
		_get_next_node()
		if _is_playing():
			_play_node()

func _on_Option_clicked(slot):
	select_choice.visible = false
	option_list.visible = false
	_get_next_node(slot)
	_clear_options()
	if _is_playing():
		_play_node()

# Public Methods

func play_dialog(record_name : String):
	_did = _Story_Reader.get_did_via_record_name(record_name)
	_nid = self._Story_Reader.get_nid_via_exact_text(_did, "<start>")
	_final_nid = _Story_Reader.get_nid_via_exact_text(_did, "<end>")
	_get_next_node()
	_play_node()
	_Dialog_Box.visible = true

func get_dialog_box_visibility():
	return _Dialog_Box.visible

# Private Methods

func _is_playing() -> bool:
	return _Dialog_Box.visible


func _is_waiting() -> bool:
	return _SpaceBar_Icon.visible


func _get_next_node(slot: int = 0):
	_nid = _Story_Reader.get_nid_from_slot(_did, _nid, slot)
	
	if _nid == _final_nid:
		_Dialog_Box.visible = false


func _get_tagged_text(tag : String, text : String):
	var start_tag = "<" + tag + ">"
	var end_tag = "</" + tag + ">"
	var start_index = text.find(start_tag) + start_tag.length()
	var end_index = text.find(end_tag)
	var substr_length = end_index - start_index
	return text.substr(start_index, substr_length)

func _inject_variables(text: String) -> String:
	var variable_count = text.count("<variable>")
	
	for i in range(variable_count):
		var variable_name = _get_tagged_text("variable", text)
		var variable_value = game_state_controller.get_data(variable_name)
		var start_index = text.find("<variable>")
		var end_index = text.find("</variable>") + "</variable>".length()
		var substr_length = end_index - start_index
		text.erase(start_index, substr_length)
		text = text.insert(start_index, str(variable_value))
	return text


func _play_node():
	var text = _Story_Reader.get_text(_did, _nid)
	text = _inject_variables(text)
	var speaker = _get_tagged_text("speaker", text)
	var dialog = _get_tagged_text("dialog", text)
	if "<choiceJSON>" in text:
		var options = _get_tagged_text("choiceJSON", text)
		_populate_choices(options)
		
	_Speaker_LBL.text = speaker
	_Body_LBL.text = dialog
	_Body_AnimationPlayer.play("TextDisplay")

func _clear_options():
	var children = option_list.get_children()
	for child in children:
		option_list.remove_child(child)
		child.queue_free()

func _populate_choices(JSONtext: String):
	var choices = {}
	choices = parse_json(JSONtext)
	
	for text in choices:
		var slot = choices[text]
		var new_option_button = option_button_scene.instance()
		option_list.add_child(new_option_button)
		new_option_button.slot = slot
		new_option_button.set_text(text)
		new_option_button.connect("clicked", self, "_on_Option_clicked")
