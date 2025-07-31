extends CharacterBody2D
class_name Box

var is_in_loop = false
var is_being_pulled = false

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var friction = 600

func _physics_process(delta: float) -> void:	
	if not is_in_loop:
		if not is_on_floor() and not is_being_pulled:
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


func _on_loopable_playback_started() -> void:
	is_in_loop = true


func _on_loopable_playback_ended() -> void:
	is_in_loop = false
