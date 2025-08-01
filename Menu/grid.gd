extends GridContainer

signal selected

func _ready() -> void:
	self.connect("selected", Callable(self,"_on_selected"));
	
func _on_selected(levelNum):
	$SelectSF.play()
	WorldManager.current_room = WorldManager.rooms[levelNum]
	WorldManager.next_room.emit()
