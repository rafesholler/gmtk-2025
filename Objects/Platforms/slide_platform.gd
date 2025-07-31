extends CharacterBody2D

@export_custom(PROPERTY_HINT_RANGE, "0,500,or_greater") var speed: float = 150

var startpoint: Vector2
var move_toward_end = false


func _ready() -> void:
	startpoint = global_position

func _physics_process(delta: float) -> void:
	if move_toward_end:
		global_position = global_position.move_toward($Endpoint.global_position, speed * delta)
	else:
		global_position = global_position.move_toward(startpoint, speed * delta)

func activate() -> void:
	move_toward_end = true


func deactivate() -> void:
	move_toward_end = false
