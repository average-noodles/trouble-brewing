extends Node

onready var _Body_AnimationPlayer = self.find_node("Body_AnimationPlayer")
onready var _Body_LBL = self.find_node("Body_Label")
onready var _Dialog_Box = self.find_node("Dialog_Box")
onready var _Speaker_LBL = self.find_node("Speaker_Label")
onready var _SpaceBar_Icon = self.find_node("SpaceBar_NinePatchRect")
onready var game_state_controller = get_node("/root/GameStateController")

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


func _input(event):
	if event is InputEventKey:
		if event.pressed == true and event.scancode == KEY_SPACE:
			_on_Dialog_Player_pressed_spacebar()

# Callback Methods

func _on_Body_AnimationPlayer_animation_finished(anim_name):
	_SpaceBar_Icon.visible = true


func _on_Dialog_Player_pressed_spacebar():
	if _is_waiting():
		_SpaceBar_Icon.visible = false
		_get_next_node()
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


func _get_next_node():
	_nid = _Story_Reader.get_nid_from_slot(_did, _nid, 0)
	
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
		
	_Speaker_LBL.text = speaker
	_Body_LBL.text = dialog
	_Body_AnimationPlayer.play("TextDisplay")
