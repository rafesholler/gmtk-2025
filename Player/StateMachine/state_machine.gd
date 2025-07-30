extends Node2D
class_name StateMachine

var states: Array[State]
var curr: int = 0

func _ready() -> void:
	for state in get_children():
		states.append(state)
		state.finished.connect(_change_state)

func _process(delta: float) -> void:
	states[curr].update(delta)

func _physics_process(delta: float) -> void:
	states[curr].physics_update(delta)

func _change_state(new_state: State, params: Array = []) -> void:
	var found = false
	states[curr].on_end()
	for i in states.size():
		if states[i] == new_state:
			found = true
			curr = i
			states[i].on_start(params)
	
	if not found:
		printerr("Could not find state " + new_state.name + " from state " + states[curr].name)


func force_state(new_state_name: String, params: Array = []) -> void:
	var new_state
	for state in states:
		if state.name == new_state_name:
			new_state = state
	if not new_state:
		printerr("Could not force state " + new_state_name)
	
	_change_state(new_state, params)
