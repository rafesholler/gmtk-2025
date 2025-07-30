extends Node
class_name Loopable

@export var properties: Array[String]
@export var make_afterimage := false

var is_looping = false


func begin_playback() -> void:
	is_looping = true
	

func end_playback() -> void:
	is_looping = false
