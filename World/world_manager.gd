extends Node

signal next_room #emits upon opening of door, used for transition
signal loaded_room #emits upon loading the next room, used for transitions
signal load_next_room #emits upon transition end to load in next room

var rooms := {
	0: "res://Levels/OneLoop/BoxPush1/box_push1.tscn",
	1: "res://Levels/OneLoop/ButtonPress1/button_press1.tscn",
	2: "res://Levels/OneLoop/BoxFreeze/box_freeze.tscn",
	3: "res://Levels/OneLoop/TwoDoors/two_doors.tscn",
	4: "res://Levels/OneLoop/MovingBox/moving_box.tscn",
}

var room_index: int = 0 :
	set(value):
		room_index = value
		current_room = rooms[value]

var current_room = rooms[0]
