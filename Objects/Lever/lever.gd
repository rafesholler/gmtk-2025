extends Area2D

signal switched(is_active: bool)

@export var afterimage_interactable := true

var is_active = false


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		is_active = not is_active
		switched.emit(is_active)
	if body.is_in_group("afterimage") and afterimage_interactable:
		is_active = not is_active
		switched.emit(is_active)
