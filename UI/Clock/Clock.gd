extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var hour_one_sprite = get_node("CanvasLayer/Hour_One")
onready var hour_two_sprite = get_node("CanvasLayer/Hour_Two")
onready var minute_one_sprite = get_node("CanvasLayer/Minute_One")
onready var minute_two_sprite = get_node("CanvasLayer/Minute_Two")
onready var animationPlayer = get_node("CanvasLayer/AnimationPlayer")
onready var meridiem_sprite = get_node("CanvasLayer/Meridiem")
onready var game_state_controller = get_node("/root/GameStateController")
onready var clock_days_sprite = get_node("CanvasLayer/ClockDays")

var time = [0,0]
var date = {
	"day": 1,
	"month": 1,
	"year": 1
	}
var day = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	animationPlayer.play("DotFlash")
	time = _get_time()
	_get_date()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time = _get_time()
	_get_date()
	_set_time(time[0],time[1])
	#_set_day(game_state_controller.get_data("date_started"))
	
func _get_time():
	var datetime = OS.get_datetime()
	var hour = datetime.hour
	var minute = datetime.minute
	return [hour, minute]

func _get_date():
	var datetime = OS.get_datetime()
	date["day"] = datetime.day
	date["month"] = datetime.month
	date["year"] = datetime.year

func _set_time(hour, minute):
	var meridiem_frame = 1
	var first_digit  = 0
	var second_digit = 0
	if hour >= 12:
		meridiem_frame = 0
	if hour > 12:
		hour -= 12
	if hour > 9:
		first_digit = 1
		second_digit = hour - 10
	else: 
		first_digit = 0
		second_digit = hour
	
	hour_one_sprite.set_frame(first_digit)
	hour_two_sprite.set_frame(second_digit)
	
	var left = floor(float(minute)/10)
	var right = minute - left * 10
	minute_one_sprite.set_frame(left)
	minute_two_sprite.set_frame(right)
	
	meridiem_sprite.set_frame(meridiem_frame)
	
func _set_day(start_date):
	day = _get_total_days(date) - _get_total_days(start_date)
	if day < 15:
		clock_days_sprite.set_frame(day)

func _get_total_days(temp_date):
	var total_days = 0
	total_days += (temp_date["year"]-1) * 365 + int((temp_date["year"]-1)/4)
	for i in range(1,temp_date["month"] - 1):
		if i in [1,3,5,7,8,10,12]:
			total_days += 31
		elif i in [4,6,9,11]:
			total_days += 30
		elif temp_date["year"]/4 - int(temp_date["year"]/4) == 0:
			total_days += 29
		else:
			total_days += 28
	total_days += temp_date["day"]
	return total_days

func get_time():
	return time

func get_date():
	return date
	
func set_day(new_day):
	if new_day < 8 and new_day > 0:
		day = new_day
		clock_days_sprite.set_frame(day - 1)

func get_day():
	return day
	
