extends CharacterBody2D
class_name HeavyBox

var is_in_loop = false

var mouse_in_area = false

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var friction = 600

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("fire") and mouse_in_area:
		if $Outline.visible:
			LoopManager.remove_loop_object(self)
		else:
			LoopManager.add_loop_object(self)
	
	if not is_in_loop:
		if not is_on_floor():
			velocity.y += gravity * delta
		
		for i in get_slide_collision_count():
			var c = get_slide_collision(i)
			if c.get_collider() is Box or c.get_collider() is HeavyBox:
				c.get_collider().velocity = -c.get_normal() * 100
		
		velocity.x = move_toward(velocity.x, 0, friction * delta)
	
		move_and_slide()


func toggle_destroy() -> void:
	visible = not visible
	$CollisionShape2D.disabled = not $CollisionShape2D.disabled


func mark() -> void:
	$Outline.visible = true
	

func unmark() -> void:
	$Outline.visible = false


func kill() -> void:
	visible = false
	$CollisionShape2D.disabled = true
	$ClickArea/CollisionShape2D.disabled = true
	

func _on_loopable_playback_started() -> void:
	is_in_loop = true


func _on_loopable_playback_ended() -> void:
	is_in_loop = false


func _on_click_area_mouse_entered() -> void:
	mouse_in_area = true


func _on_click_area_mouse_exited() -> void:
	mouse_in_area = false
