extends Node2D
class_name State

@export var target: Node2D

signal finished(next_state: State)

func on_start(params: Array = []) -> void:
	pass
	
func update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	pass

func on_end() -> void:
	pass

func get_neighbor(name: String) -> State:
	for state in get_parent().get_children():
		if state.name == name:
			return state
	return null
