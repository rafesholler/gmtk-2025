extends Area2D

signal switched(is_active: bool)

@export var afterimage_interactable := true

var is_active = false

func _process(delta: float) -> void:
	if is_active and $AnimatedSprite2D.animation != "switch_on":
		$LeverSF.pitch_scale = randf_range(.8, 1.2)
		$LeverSF.play()
		$AnimatedSprite2D.play("switch_on")
	elif not is_active and $AnimatedSprite2D.animation == "switch_on":
		$LeverSF.pitch_scale = randf_range(.8, 1.2)
		$LeverSF.play()
		$AnimatedSprite2D.play("switch_off")


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		is_active = not is_active
		switched.emit(is_active)
	if body.is_in_group("afterimage") and afterimage_interactable:
		is_active = not is_active
		switched.emit(is_active)
