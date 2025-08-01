extends CharacterBody2D

var inside = false
var target_position

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("fire") and inside:
		target_position = get_global_mouse_position()
		position = lerp(position, target_position, .25)
	elif not is_on_floor():
		velocity.y = 980
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	inside = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	inside = false
