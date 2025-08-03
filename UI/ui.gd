extends Control

func _ready() -> void:
	WorldManager.connect("next_room", Callable(self,"_on_next_room")); 
	WorldManager.connect("loaded_room", Callable(self, "_on_room_load"))

func _process(delta: float) -> void:
	if WorldManager.current_room == "res://Menu/Title.tscn":
		$Transition/Screen/Title.visible=false
	elif WorldManager.current_room == "res://Menu/LevelSelect.tscn":
		$Transition/Screen/Title.visible=false
	elif WorldManager.current_room == "res://Menu/Settings/settings.tscn":
		$Transition/Screen/Title.visible=false
	else:
		$Transition/Screen/Title.visible=true
func _on_next_room():
	if WorldManager.room_index != -1:
		$Transition/Screen/Title.text = WorldManager.get_level_name(WorldManager.room_index)
	$Transition.enter_screen()
	LoopManager.cancel_all_loops()
	LoopManager.index = 0

func _on_room_load():
	$Transition.exit_screen()
