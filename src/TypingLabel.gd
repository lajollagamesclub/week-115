extends Label # cannot be tool script

const keypress_audio_prefix = "keypress-"
const keypress_audio_suffix = ".wav"
const number_of_keypresses = 3

export var typing_smoothing = 10.0
export var initial_delay = 0.5
export var horizontal_cursor_offset = 20.0
export var character_time_range = Vector2()

var target_text = "error"

var initial_delay_counter = 0.0
var character_time_counter = 0.0
var time = 0.0
var keypress_audio_paths = []
var smoothed_cursor_x = 0.0
var target_cursor_x = 0.0
onready var character_time = character_time_range.x

func _ready():
	randomize()
	
	for i in range(1, number_of_keypresses + 1):
		keypress_audio_paths.append(str(keypress_audio_prefix, i, keypress_audio_suffix))
	
	target_text = text
	text = ""

func _physics_process(delta):
	time += delta
	$TypingCursor.material.set_shader_param("sin_time", time)
	
	var typing_c = typing_smoothing * delta
	smoothed_cursor_x = ((target_cursor_x - smoothed_cursor_x) * typing_c) + smoothed_cursor_x
	$TypingCursor.rect_position.x = smoothed_cursor_x

func _process(delta):
	if initial_delay_counter < initial_delay:
		initial_delay_counter += delta
		return
	if character_time_counter < character_time:
		character_time_counter += delta
	else:
		if target_text == "":
			set_process(false)
			return
		
		character_time_counter = 0.0
		character_time = rand_range(character_time_range.x, character_time_range.y)

		$TypingStreamPlayer.stream = load(keypress_audio_paths[randi()%number_of_keypresses])
		$TypingStreamPlayer.play()
		
		text += target_text[0]
		
		time = 0.0
		
		
		target_cursor_x = get_combined_minimum_size().x + horizontal_cursor_offset
		
		
		target_text = target_text.right(1)