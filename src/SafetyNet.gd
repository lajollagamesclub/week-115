extends Area2D

func _on_PillowArea2D_body_entered(body):
	if body is Player:
		$FluffPlayer.play()
		$Sprite.play("bounce")
		$Sprite.frame = 0
#		$CPUParticles2D.restart()
#		$CPUParticles2D.emitting = true