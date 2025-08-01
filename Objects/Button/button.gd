extends Area2D

signal just_pressed
signal just_unpressed

@export var afterimage_interactable := true

var bodies_in_area = []
var pressed = false

func _process(delta: float) -> void:
	if bodies_in_area.size() >= 1:
		pressed = true
		$AnimatedSprite2D.play("pressed")
	else:
		pressed = false
		$AnimatedSprite2D.play("default")
		

func _on_body_entered(body: Node2D) -> void:
	$ButtonPress.pitch_scale = randf_range(0.8, 1.0)
	$ButtonPress.play()
	if body is Player or Box or HeavyBox:
		bodies_in_area.append(body)
		if bodies_in_area.size() == 1:
			just_pressed.emit()
	if body.is_in_group("afterimage") and afterimage_interactable:
		bodies_in_area.append(body)
		if bodies_in_area.size() == 1:
			just_pressed.emit()


func _on_body_exited(body: Node2D) -> void:
	if body is Player or Box or HeavyBox:
		bodies_in_area.erase(body)
		if bodies_in_area.size() == 0:
			just_unpressed.emit()
	if body.is_in_group("afterimage") and afterimage_interactable:
		bodies_in_area.erase(body)
		if bodies_in_area.size() == 0:
			just_unpressed.emit()
