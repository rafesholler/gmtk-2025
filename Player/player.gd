extends CharacterBody2D
class_name Player

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var is_pulling = false
var nearby_box: Box

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
	
	if is_pulling and nearby_box and not nearby_box.is_in_loop:
		if $AnimatedSprite2D.flip_h:
			nearby_box.global_position = $BoxPosLeft.global_position
		else:
			nearby_box.global_position = $BoxPosRight.global_position
	
	if Input.is_action_just_pressed("interact") and nearby_box and not nearby_box.is_in_loop:
		is_pulling = not is_pulling
		if is_pulling:
			$Audio/Pickup.pitch_scale = randf_range(0.8, 1.2)
			$Audio/Pickup.play()
			nearby_box.collision_layer = 32
			nearby_box.collision_mask = 3
			nearby_box.is_being_pulled = true
		else:
			$Audio/Pickup.pitch_scale = randf_range(0.4, .8)
			$Audio/Pickup.play()
			nearby_box.is_being_pulled = false
			nearby_box.collision_layer = 4
			nearby_box.collision_mask = 7
	
	if Input.is_action_just_pressed("toggle_record"):
		LoopManager.add_loop_object(self)
		
		if LoopManager.is_recording:
			LoopManager.stop_recording()
		else:
			LoopManager.start_recording()
	
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is Box and not c.get_collider().is_in_loop:
			c.get_collider().velocity = -c.get_normal() * push_force
			#print(c.get_collider().velocity)
		if c.get_collider() is HeavyBox and not c.get_collider().is_in_loop:
			c.get_collider().velocity = -c.get_normal() * push_force
	
	if not LoopManager.is_recording:
		if Input.is_action_just_pressed("select_loop_1"):
			LoopManager.index = 0
		if Input.is_action_just_pressed("select_loop_2"):
			LoopManager.index = 1
		if Input.is_action_just_pressed("select_loop_3"):
			LoopManager.index = 2
	
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
		is_pulling = false


func _on_coyote_timer_timeout() -> void:
	coyote_window = false
