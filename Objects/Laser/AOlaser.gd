extends Area2D

func _on_body_entered(body: Node2D) -> void:
	WorldManager.reset_level()
	WorldManager.kill_player.emit()
	$LaserDeath.play()
