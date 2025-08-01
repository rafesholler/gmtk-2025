extends Control

func exit_screen():
	$Screen/TransitionIn.visible = false
	$Screen/TransitionOut.visible = true
	var start = get_tree().create_tween()
	start.set_trans(Tween.TRANS_SINE)
	start.tween_property($Screen, "position", Vector2(-2000, 0), 1).set_ease(Tween.EASE_IN)

func enter_screen():
	$Screen/TransitionIn.visible = true
	$Screen/TransitionOut.visible = false
	var end = get_tree().create_tween()
	end.set_trans(Tween.TRANS_SINE)
	end.tween_property($Screen, "position", Vector2(0, 0), 1).set_ease(Tween.EASE_OUT)
	await end.finished
	WorldManager.load_next_room.emit()
