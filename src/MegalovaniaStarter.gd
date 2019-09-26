extends Node2D

var counter = 0.0

func _process(delta):
	counter += delta
	if ((counter/60)/60) > 7.0:
		$AudioStreamPlayer.play()
		counter = 0.0
		set_process(false)
		return