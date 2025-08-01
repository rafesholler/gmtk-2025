extends CharacterBody2D

var target_position
var start = 80.0

func _physics_process(delta: float) -> void:
	target_position = get_global_mouse_position()
	position.x = lerp(position.x, target_position.x, .2)
	if Input.is_action_pressed("fire"):
		position.y = lerp(position.y, target_position.y, .2)
		$Sprite.play("close")
	else:
		position.y = lerp(position.y, start, .3)
		$Sprite.play("open")
	
	move_and_slide()
