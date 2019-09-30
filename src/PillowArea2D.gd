extends Area2D

func _on_PillowArea2D_body_entered(body):
	if body is Player:
		$FluffPlayer.play()