extends ColorRect

func _ready():
	set_process(false)

func _process(delta):
	if color.a <= 0.0:
		set_process(false)
		return
	color.a -= 0.5*delta

func _on_YoungPlayer_bonked():
	color.a = 1.0
	set_process(true)