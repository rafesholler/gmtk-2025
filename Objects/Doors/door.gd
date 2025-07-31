extends CharacterBody2D
class_name Door

func open() -> void:
	$CollisionShape2D.disabled = true
