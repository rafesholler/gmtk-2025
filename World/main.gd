extends Node2D

@onready var current_room = load(WorldManager.current_room)

func _ready() -> void:
	WorldManager.connect("load_next_room", Callable(self,"_load_next_room"));
	add_child(current_room.instantiate())

func _load_next_room():
	current_room = load(WorldManager.current_room)
	add_child(current_room.instantiate())

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("reset"):
		WorldManager.reset_level()
		$Reset.play()
