extends Node

signal next_room #emits upon opening of door, used for transition
signal loaded_room #emits upon loading the next room, used for transitions
signal load_next_room #emits upon transition end to load in next room

var rooms := {
	0: "start_room",
	1: "test_room"
}

var room_index: int = 0 :
	set(value):
		room_index = value
		current_room = rooms[value]

var current_room = rooms[0]
