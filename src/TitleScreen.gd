extends Control

func _ready():
	$"PlayButton".connect("pressed", self, "PLAY")
	$"OptionsButton".connect("pressed", self, "OPTIONS")
	$"QuitButton".connect("pressed", self, "QUIT")
	pass
	
func PLAY():
	pass
	
func OPTIONS():
	pass

func QUIT():
	pass