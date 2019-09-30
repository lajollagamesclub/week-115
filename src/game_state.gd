extends Resource

const max_age = 3
const max_time = 90.0

signal age_changed(new_age)
signal time_left_changed(new_time_left)

var cur_age: int = 0

var time_left = max_time setget set_time_left

func set_time_left(new_time_left):
	time_left = new_time_left
# warning-ignore:narrowing_conversion
	var new_age: int = max_age - ceil(time_left/(max_time / max_age))
	if new_age != cur_age:
		emit_signal("age_changed", new_age)
		cur_age = new_age
	emit_signal("time_left_changed", new_time_left)