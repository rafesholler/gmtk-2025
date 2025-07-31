extends State

func on_start(params: Array = []) -> void:
	target.get_node("AnimatedSprite2D").play("idle")
	target.velocity.x = 0
	
func update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	target.move_and_slide()
	
	if not target.is_on_floor():
		finished.emit(get_neighbor("Fall"))
	
	elif Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		finished.emit(get_neighbor("Run"))

func on_end() -> void:
	pass
