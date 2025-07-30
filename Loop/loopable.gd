extends Node
class_name Loopable

signal playback_started
signal playback_ended

@export var properties: Dictionary[Node, Array]
@export var make_afterimage := false

var is_looping = false


func begin_playback() -> void:
	is_looping = true
	playback_started.emit()
	

func end_playback() -> void:
	is_looping = false
	playback_ended.emit()
