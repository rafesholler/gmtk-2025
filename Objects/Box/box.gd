extends CharacterBody2D
class_name Box

var is_in_loop = false

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var friction = 600

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y = gravity
	
	velocity.x = move_toward(velocity.x, 0, friction * delta)
	
	move_and_slide()


func _on_loopable_playback_started() -> void:
	is_in_loop = true


func _on_loopable_playback_ended() -> void:
	is_in_loop = false
