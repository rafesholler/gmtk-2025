extends CharacterBody2D
class_name Player

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var is_pulling = false
var nearby_box: Box
var box_vector

var jumped = false
var coyote_window = false

@export var speed = 200
@export var push_force = 100

func _process(delta: float) -> void:
	var dir = Input.get_axis("move_left", "move_right")
	
	if dir < 0 and not $AnimatedSprite2D.flip_h:
		$AnimatedSprite2D.flip_h = true
	if dir > 0 and $AnimatedSprite2D.flip_h:
		$AnimatedSprite2D.flip_h = false


func _physics_process(delta: float) -> void:
	if is_on_floor():
		jumped = false
		coyote_window = true
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = -200
		jumped = true
	
	elif Input.is_action_just_pressed("jump"):
		$JumpCutTimer.start(.2)
	
	if is_on_floor() and not $JumpCutTimer.is_stopped():
		velocity.y = -200
		jumped = true
	
	if not is_on_floor() and not jumped and $CoyoteTimer.is_stopped() and coyote_window:
		$CoyoteTimer.start(.1)
		coyote_window = true
	
	if not is_on_floor() and coyote_window and not $CoyoteTimer.is_stopped():
		if Input.is_action_just_pressed("jump"):
			velocity.y = -200
			jumped = true
	
	if Input.is_action_just_pressed("pull") and nearby_box and not nearby_box.is_in_loop:
		is_pulling = not is_pulling
		if is_pulling:
			nearby_box.collision_layer = 32
			nearby_box.collision_mask = 3
			box_vector = nearby_box.position - position
			box_vector.y = -25
			nearby_box.is_being_pulled = true
		else:
			box_vector = null
			nearby_box.is_being_pulled = false
			nearby_box.collision_layer = 4
			nearby_box.collision_mask = 7
	
	if is_pulling and nearby_box and not nearby_box.is_in_loop and box_vector:
			nearby_box.position = position + box_vector
		
	
	$RayCast2D.target_position = get_global_mouse_position() - position - $RayCast2D.position
	
	if Input.is_action_just_pressed("fire"):
		if $RayCast2D.is_colliding():
			for child in $RayCast2D.get_collider().get_children():
				if child is Loopable:
					LoopManager.add_loop_object($RayCast2D.get_collider())
					break
	
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
			#print(c.get_collider().velocity)
		if c.get_collider() is HeavyBox and not c.get_collider().is_in_loop:
			c.get_collider().velocity = -c.get_normal() * push_force

	if Input.is_action_just_pressed("change_loop"):
		if LoopManager.is_recording:
			return
		LoopManager.index += 1
		if LoopManager.index >= 3:
			LoopManager.index = 0
	
	if Input.is_action_just_pressed("delete_loop"):
		LoopManager.cancel_loop(LoopManager.index)

	$Label.text = "Loop: " + str(LoopManager.index) + " Recording: " + str(LoopManager.is_recording)


func _on_pull_range_body_entered(body: Node2D) -> void:
	if body is Box and not is_pulling:
		nearby_box = body


func _on_pull_range_body_exited(body: Node2D) -> void:
	if body == nearby_box:
		nearby_box.is_being_pulled = false
		nearby_box.collision_layer = 4
		nearby_box.collision_mask = 7
		nearby_box = null
		box_vector = null
		is_pulling = false


func _on_coyote_timer_timeout() -> void:
	coyote_window = false
