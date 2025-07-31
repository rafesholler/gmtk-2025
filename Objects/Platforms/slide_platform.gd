extends CharacterBody2D

@export_custom(PROPERTY_HINT_RANGE, "0,500,or_greater") var speed: float = 150
var active = false

func _physics_process(delta: float) -> void:
	if active:
		global_position = global_position.move_toward($Endpoint.global_position, speed * delta)


func activate() -> void:
	active = true
