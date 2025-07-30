extends State

func on_start(params: Array = []) -> void:
	target.get_node("AnimatedSprite2D").play("run")
	
func update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	var dir = Input.get_axis("move_left", "move_right")
	target.velocity.x = target.speed * dir
	target.move_and_slide()
	
	if not target.is_on_floor():
		finished.emit(get_neighbor("Fall"))
	
	elif Input.get_axis("move_left", "move_right") == 0:
		finished.emit(get_neighbor("Idle"))
	
	elif Input.is_action_pressed("jump"):
		finished.emit(get_neighbor("Jump"))

func on_end() -> void:
	pass
