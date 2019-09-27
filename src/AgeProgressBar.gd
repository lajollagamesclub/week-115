extends ProgressBar

const game_state = preload("res://game_state.tres")

func _ready():
	max_value = game_state.max_time
	game_state.connect("time_left_changed", self, "_time_left_changed")

func _process(delta):
	game_state.time_left -= delta

func _time_left_changed(new_time_left):
	value = new_time_left