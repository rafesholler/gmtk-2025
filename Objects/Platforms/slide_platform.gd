extends CharacterBody2D

@export_custom(PROPERTY_HINT_RANGE, "0,.1,or_greater") var speed: float = .06

var startpoint: Vector2
var move_toward_end = false


func _ready() -> void:
	startpoint = global_position

func _physics_process(delta: float) -> void:
	if move_toward_end:
		global_position = lerp(global_position, $Endpoint.global_position, speed)
	else:
		global_position = lerp(global_position, startpoint, speed)

func activate() -> void:
	move_toward_end = true
	#$Slide.pitch_scale = randf_range(1.0,1.5)
	#$Slide.play()


func deactivate() -> void:
	#$Slide.pitch_scale = randf_range(1.0,1.5)
	#$Slide.play()
	move_toward_end = false
	
