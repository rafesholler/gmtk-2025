extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var push_force = 200

func _physics_process(delta: float) -> void:
	velocity.x = Input.get_axis("move_left", "move_right") * 300
	
	if velocity.x != 0:
		$AnimatedSprite2D.play("run")
	else:
		$AnimatedSprite2D.play("idle")
	
	if velocity.x < 0 and not $AnimatedSprite2D.flip_h:
		$AnimatedSprite2D.flip_h = true
	if velocity.x > 0 and $AnimatedSprite2D.flip_h:
		$AnimatedSprite2D.flip_h = false
	
	if Input.is_action_pressed("jump"):
		velocity.y = -400
	
	elif not is_on_floor():
		velocity.y = gravity
	
	
	if Input.is_action_just_pressed("toggle_record") or Input.is_action_just_pressed("record_with_player"):
		if Input.is_action_just_pressed("record_with_player"):
			LoopManager.add_loop_object(self)
		LoopManager.is_recording = not LoopManager.is_recording
		
		if LoopManager.is_recording:
			LoopManager.start_recording()
		else:
			LoopManager.stop_recording()
	
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is Box and not c.get_collider().is_in_loop:
			c.get_collider().velocity = -c.get_normal() * push_force
	
	$RayCast2D.target_position = get_global_mouse_position() - position - $RayCast2D.position
	
	if Input.is_action_just_pressed("fire"):
		if $RayCast2D.is_colliding():
			for child in $RayCast2D.get_collider().get_children():
				if child is Loopable:
					LoopManager.add_loop_object($RayCast2D.get_collider())
					break

	if Input.is_action_just_pressed("change_loop"):
		if LoopManager.is_recording:
			return
		LoopManager.index += 1
		if LoopManager.index >= 3:
			LoopManager.index = 0
	
	if Input.is_action_just_pressed("delete_loop"):
		LoopManager.cancel_loop(LoopManager.index)

	$Label.text = str(LoopManager.index)

	move_and_slide()
