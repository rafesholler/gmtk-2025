extends Node2D

func _ready() -> void:
	WorldManager.loaded_room.emit()
	LoopManager.max_loops = 3
	
	var buttons = ["1", "2", "3", "4", "5", "6", "7", "8"]
	for b in buttons:
		get_node("Button" + b).just_pressed.connect(_on_button_just_pressed.bind(b))
		get_node("Button" + b).just_unpressed.connect(_on_button_just_unpressed.bind(b))


func _on_button_just_pressed(button: String) -> void:
	get_node("SlidePlatform" + button).activate()


func _on_button_just_unpressed(button: String) -> void:
	get_node("SlidePlatform" + button).deactivate()
