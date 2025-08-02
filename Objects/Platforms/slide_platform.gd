extends CharacterBody2D

@export_custom(PROPERTY_HINT_RANGE, "0,.1,or_greater") var speed: float = .06
@export var frame_delay: int = 0
var frame_counter = 0

var startpoint: Vector2
var move_toward_end = false


func _ready() -> void:
	startpoint = global_position

func _physics_process(delta: float) -> void:
	frame_counter += 1
	if frame_delay == 0 or frame_counter % frame_delay == 0:
		if move_toward_end:
			global_position = lerp(global_position, $Endpoint.global_position, speed)
		else:
			global_position = lerp(global_position, startpoint, speed)

func activate() -> void:
	move_toward_end = true
	$Slide.pitch_scale = randf_range(1.0,1.5)
	$Slide.play()


func deactivate() -> void:
	$Slide.pitch_scale = randf_range(1.0,1.5)
	$Slide.play()
	move_toward_end = false
	
