extends Area2D

func _on_body_entered(body: Node2D) -> void:
	WorldManager.next_room.emit()
	LoopManager.clear_marked_objects()
	LoopManager.cancel_loop(0)
	LoopManager.cancel_loop(1)
	LoopManager.cancel_loop(2)
