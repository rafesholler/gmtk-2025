extends Node

signal next_room #emits upon opening of door, used for transition
signal loaded_room #emits upon loading the next room, used for transitions
signal load_next_room #emits upon transition end to load in next room

var current_room = 1
