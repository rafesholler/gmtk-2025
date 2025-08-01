extends Control

func _ready() -> void:
	WorldManager.connect("next_room", Callable(self,"_on_next_room")); 
	WorldManager.connect("loaded_room", Callable(self, "_on_room_load"))

func _on_next_room():
	$Transition.enter_screen()
	LoopManager.cancel_loop(0)
	LoopManager.cancel_loop(1)
	LoopManager.cancel_loop(2)

func _on_room_load():
	$Transition.exit_screen()
