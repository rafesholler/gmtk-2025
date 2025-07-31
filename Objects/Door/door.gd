extends Node2D

var inside

func _ready() -> void:
	WorldManager.connect("load_next_room", Callable(self,"_on_next_room"));

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("pull") and inside:
		$Sprite.play("open")

func _on_area_2d_area_entered(area: Area2D) -> void:
	inside = true

func _on_area_2d_area_exited(area: Area2D) -> void:
	inside = false

func _on_sprite_animation_finished() -> void:
	WorldManager.current_room += 1
	WorldManager.next_room.emit()

func _on_next_room():
	LoopManager.cancel_loop(0)
	LoopManager.cancel_loop(1)
	LoopManager.cancel_loop(2)
	get_parent().queue_free()
