extends CharacterBody2D
class_name HeavyBox

var is_in_loop = false

var mouse_in_area = false

var can_collide = true

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var friction = 600

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("fire") and mouse_in_area and not is_in_loop:
		$SelectSF.pitch_scale = randf_range(0.8, 1.2)
		$SelectSF.play()
		if $Outline.visible:
			LoopManager.remove_loop_object(self)
		else:
			LoopManager.add_loop_object(self)
	
	if not is_in_loop:
		can_collide = true
		collision_layer = 4
		collision_mask = 7
		
		if not is_on_floor():
			velocity.y += gravity * delta
		
		for i in get_slide_collision_count():
			var c = get_slide_collision(i)
			if c.get_collider() is Box or c.get_collider() is HeavyBox:
				c.get_collider().velocity = -c.get_normal() * 100
		
		velocity.x = move_toward(velocity.x, 0, friction * delta)
	
		move_and_slide()


func mark() -> void:
	$Outline.visible = true
	

func unmark() -> void:
	$Outline.visible = false


func toggle_destroy() -> void:
	visible = not visible
	$CollisionShape2D.disabled = not $CollisionShape2D.disabled
	$ClickArea/CollisionShape2D.disabled = not $ClickArea/CollisionShape2D.disabled


func toggle_collisions() -> void:
	can_collide = not can_collide
	if can_collide:
		collision_layer = 4
		collision_mask = 7
	else:
		collision_layer = 0
		collision_mask = 0


func _on_loopable_playback_started() -> void:
	is_in_loop = true


func _on_loopable_playback_ended() -> void:
	is_in_loop = false


func _on_click_area_mouse_entered() -> void:
	mouse_in_area = true


func _on_click_area_mouse_exited() -> void:
	mouse_in_area = false
