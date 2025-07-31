extends State

func on_start(params: Array = []) -> void:
	target.get_node("AnimatedSprite2D").play("jump")
	
func update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	target.velocity.y += target.gravity * delta
	target.move_and_slide()
	
	var dir = Input.get_axis("move_left", "move_right")
	if dir == 0:
		target.velocity.x = 0
	else:
		target.velocity.x = target.speed * dir

	if target.is_on_floor():
		if dir == 0:
			finished.emit(get_neighbor("Idle"))
		else:
			finished.emit(get_neighbor("Run"))
	

func on_end() -> void:
	pass
