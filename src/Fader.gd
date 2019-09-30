extends ColorRect

const game_state = preload("res://game_state.tres")

var target_scene: String = ""

func _ready():
	game_state.connect("fade_to_scene", self, "fade")
	set_process(false)

func fade(in_target_scene):
	target_scene = in_target_scene
	set_process(true)

func _process(delta):
	color.a += delta/2.0
	if color.a >= 1.0:
		get_tree().change_scene(target_scene)
		game_state.fading = false