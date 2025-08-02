extends CharacterBody2D
class_name SlidePlatform

@export_custom(PROPERTY_HINT_RANGE, "0,.1,or_greater") var speed: float = .06
@export var frame_delay: int = 0
var frame_counter = 0

var startpoint: Vector2
var move_toward_end = false

var can_move = true


func _ready() -> void:
	startpoint = global_position
	$AnimatableBody2D.add_collision_exception_with(self)
	add_collision_exception_with($AnimatableBody2D)

func _physics_process(delta: float) -> void:
	frame_counter += 1
	if frame_delay == 0 or frame_counter % frame_delay == 0:
		if move_toward_end and can_move:
			global_position = lerp(global_position, $Endpoint.global_position, speed)
		elif can_move:
			global_position = lerp(global_position, startpoint, speed)
	
	move_and_collide(Vector2.ZERO)

func activate() -> void:
	if not move_toward_end:
		move_toward_end = true
		$Slide.pitch_scale = randf_range(1.0,1.5)
		$Slide.play()


func deactivate() -> void:
	if move_toward_end:
		$Slide.pitch_scale = randf_range(1.0,1.5)
		$Slide.play()
		move_toward_end = false
	
