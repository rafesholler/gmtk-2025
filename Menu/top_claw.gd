extends CharacterBody2D

var target_position
var start = 80.0
var dropping = false

func _physics_process(delta: float) -> void:
	target_position = get_global_mouse_position()
	if !dropping:
		position.x = lerp(position.x, target_position.x, .1)
	if Input.is_action_pressed("fire"):
		dropping = true
		position.y = lerp(position.y, target_position.y, .1)
		$Sprite.play("close")
	else:
		position.y = lerp(position.y, start, .3)
		dropping = false
		$Sprite.play("open")
	
	move_and_slide()
