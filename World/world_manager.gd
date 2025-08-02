extends Node

signal next_room #emits upon opening of door, used for transition
signal loaded_room #emits upon loading the next room, used for transitions
signal load_next_room #emits upon transition end to load in next room
signal kill_player 

var rooms := {
	-1: "res://Menu/Title.tscn",
	0: "res://Levels/OneLoop/BoxPush1/box_push1.tscn",
	1: "res://Levels/OneLoop/ButtonPress1/button_press1.tscn",
	2: "res://Levels/OneLoop/TeleportingBox/teleporting_box.tscn",
	3: "res://Levels/OneLoop/MovingBox/moving_box.tscn",
	4: "res://Levels/OneLoop/BoxFreeze/box_freeze.tscn",
	5: "res://Levels/OneLoop/TwoDoors/two_doors.tscn",
	6: "res://Levels/TwoLoop/TwoBoxes/two_boxes.tscn",
	7: "res://Levels/TwoLoop/FlipSwitch/flip_switch.tscn",
	8: "res://Levels/TwoLoop/Bridge/bridge.tscn",
	9: "res://Levels/TwoLoop/Tower/tower.tscn",
	10: "res://Levels/TwoLoop/Speedrun/speedrun.tscn",
	11: "res://Levels/TwoLoop/PortalPlatform/portal_platform.tscn",
	12: "res://Levels/ThreeLoop/SliderCity/slider_city.tscn",
	13: "res://Menu/Title.tscn",
}

var room_index: int = 0 :
	set(value):
		room_index = value
		current_room = rooms[value]

var current_room = "res://Menu/Title.tscn"

var master_volume: float = -10 : 
	set(value):
		if value == -35:
			value = -70
		AudioServer.set_bus_volume_db(0, value)
		print(AudioServer.get_bus_name(0) + ": " + str(AudioServer.get_bus_volume_db(0)))
		master_volume = value
		
var music_volume: float = -10 : 
	set(value):
		if value == -35:
			value = -70
		AudioServer.set_bus_volume_db(1, value)
		print(AudioServer.get_bus_name(1) + ": " + str(AudioServer.get_bus_volume_db(1)))
		music_volume = value
		
var sound_volume: float = -10 : 
	set(value):
		if value == -35:
			value = -70
		AudioServer.set_bus_volume_db(2, value)
		print(AudioServer.get_bus_name(2) + ": " + str(AudioServer.get_bus_volume_db(2)))
		sound_volume = value
		


func reset_level() -> void:
	next_room.emit()
	LoopManager.clear_marked_objects()
	LoopManager.cancel_all_loops()
	LoopManager.index = 0


func get_level_name(number: int) -> String:
	match number:
		0:
			return "Boxes"
		1:
			return "Button Press"
		2:
			return "Big Heavy Box"
		3:
			return "Sliding Platforms"
		4:
			return "Blocked Exit"
		5:
			return "Two Doors"
		6:
			return "Two Boxes"
		7:
			return "Flip Switch"
		8:
			return "Bridge"
		9:
			return "Tower"
		10:
			return "Speedrun"
		11:
			return "Portal Platform"
		12:
			return "Slider City"
		_:
			printerr("Cannot find name of level " + str(number))
			return "MISSING STRING"
