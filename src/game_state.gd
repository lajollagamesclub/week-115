extends Resource

const max_age = 3
const max_time = 90.0
const events = [ 
	"bounce",
	"big_bounce",
	"flame" ]

signal age_changed(new_age)
signal time_left_changed(new_time_left)
signal event(event_name, event_data)
signal fade_to_scene(scene_path)

var cur_age: int = 0
var fading: bool = false
var time_left = max_time setget set_time_left

func set_time_left(new_time_left):
	time_left = new_time_left
# warning-ignore:narrowing_conversion
	var new_age: int = max_age - ceil(time_left/(max_time / max_age))
	if new_age != cur_age:
		emit_signal("age_changed", new_age)
		cur_age = new_age
	emit_signal("time_left_changed", new_time_left)

func fade_to_scene(scene_path):
	if fading:
		return
	fading = true
	emit_signal("fade_to_scene", scene_path)

func emit_event(event_type: String, event_data):
	if event_type in events:
		emit_signal("event", event_type, event_data)
	else:
		printerr("Unknown event: ", event_type)