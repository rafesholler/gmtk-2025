extends CharacterBody2D
class_name Player

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var nearby_box
var box_vector

@export var speed = 100
@export var push_force = 200

func _process(delta: float) -> void:
	var dir = Input.get_axis("move_left", "move_right")
	if dir != 0 and $AnimatedSprite2D.animation != "run":
		$AnimatedSprite2D.play("run")
	elif dir == 0 and $AnimatedSprite2D.animation != "idle":
		$AnimatedSprite2D.play("idle")
	
	if dir < 0 and not $AnimatedSprite2D.flip_h:
		$AnimatedSprite2D.flip_h = true
	if dir > 0 and $AnimatedSprite2D.flip_h:
		$AnimatedSprite2D.flip_h = false


func _physics_process(delta: float) -> void:
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = -100
	
	if Input.is_action_just_pressed("pull"):
		if nearby_box and not nearby_box.is_in_loop:
			box_vector = nearby_box.position - position
	if Input.is_action_pressed("pull"):
		if nearby_box and not nearby_box.is_in_loop:
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
	
	print($StateMachine.states[$StateMachine.curr].name)
	print(velocity)
	move_and_slide()


func _on_pull_range_body_entered(body: Node2D) -> void:
	if body is Box:
		nearby_box = body


func _on_pull_range_body_exited(body: Node2D) -> void:
	if body == nearby_box:
		nearby_box = null
