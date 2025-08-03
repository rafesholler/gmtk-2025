extends TextureRect

func _ready() -> void:
	floating()

func floating():
	var down = get_tree().create_tween()
	down.set_trans(Tween.TRANS_SINE)
	down.tween_property(self, "position", Vector2(225, 65), 2).set_ease(Tween.EASE_IN_OUT)
	await down.finished
	var up = get_tree().create_tween()
	up.set_trans(Tween.TRANS_SINE)
	up.tween_property(self, "position", Vector2(225, 45), 2).set_ease(Tween.EASE_IN_OUT)
	await up.finished
	floating()
