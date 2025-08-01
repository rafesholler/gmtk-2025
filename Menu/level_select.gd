extends Node2D

func _ready() -> void:
	WorldManager.loaded_room.emit()
	WorldManager.connect("load_next_room", Callable(self,"_on_next_room"));
	
	for level in $CanvasLayer/Grid.get_children():
		if level is TextureButton:
			level.mouse_entered.connect(_on_level_mouse_entered.bind(level.number))
			level.mouse_exited.connect(_on_level_mouse_exited)
	
func _on_next_room():
	queue_free()


func _on_level_mouse_entered(level_num: int) -> void:
	var name = ""
	match level_num:
		0:
			name = "Boxes"
		1:
			name = "Button Press"
		2:
			name = "Big Heavy Box"
		3:
			name = "Sliding Platforms"
		4:
			name = "Blocked Exit"
		5:
			name = "Two Doors"
		6:
			name = "Two Boxes"
	
	$CanvasLayer/LevelName.text = name


func _on_level_mouse_exited() -> void:
	$CanvasLayer/LevelName.text = ""
