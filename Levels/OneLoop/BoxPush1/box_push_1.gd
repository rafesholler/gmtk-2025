extends Node2D

func _ready() -> void:
	WorldManager.loaded_room.emit()
	LoopManager.max_loops = 1

func _on_trigger_body_entered(body: Node2D) -> void:
	WorldManager.room_index = -1
	var drop = get_tree().create_tween()
	drop.set_trans(Tween.TRANS_SINE)
	drop.tween_property($Title, "position", Vector2(180, 108), 2).set_ease(Tween.EASE_OUT)
