extends State

func on_start(params: Array = []) -> void:
	$JumpHoldTimer.start(.3)
	
func update(delta: float) -> void:
	var dir = Input.get_axis("move_left", "move_right")
	if dir == 0:
		target.get_node("AnimatedSprite2D").play("idle")
	else:
		target.get_node("AnimatedSprite2D").play("run")

func physics_update(delta: float) -> void:
	if Input.is_action_pressed("jump") and not $JumpHoldTimer.is_stopped():
		if target.velocity.y == 0:
			finished.emit(get_neighbor("Fall"))
		target.velocity.y = -100
	
	if not Input.is_action_pressed("jump"):
		$JumpHoldTimer.stop()
		finished.emit(get_neighbor("Fall"))
	
	var dir = Input.get_axis("move_left", "move_right")
	target.velocity.x = target.speed * dir
	
	
	
	target.move_and_slide()

func on_end() -> void:
	$JumpHoldTimer.stop()


func _on_jump_hold_timer_timeout() -> void:
	finished.emit(get_neighbor("Fall"))
