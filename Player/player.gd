extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var is_recording = false

func _physics_process(delta: float) -> void:
	velocity.x = Input.get_axis("move_left", "move_right") * 300
	
	if Input.is_action_pressed("jump"):
		velocity.y = -400
	
	elif not is_on_floor():
		velocity.y = gravity
	
	
	if Input.is_action_just_pressed("toggle_record") or Input.is_action_just_pressed("record_with_player"):
		if Input.is_action_just_pressed("record_with_player"):
			LoopManager.add_loop_object(self)
		is_recording = not is_recording
		
		if is_recording:
			LoopManager.start_recording()
		else:
			LoopManager.stop_recording()
	
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() * 200)
	
	$RayCast2D.target_position = get_global_mouse_position() - position - $RayCast2D.position
	
	if Input.is_action_just_pressed("fire"):
		if $RayCast2D.is_colliding():
			for child in $RayCast2D.get_collider().get_children():
				if child is Loopable:
					LoopManager.add_loop_object($RayCast2D.get_collider())
					break

	
	move_and_slide()
