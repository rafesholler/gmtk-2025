extends Node

var loops: Array[Loop] = []
var index = 0

var curr_loop_objects: Array[Node] = []

var is_recording = false


var afterimage_path = preload("res://Player/afterimage.tscn")


func _ready() -> void:
	loops.append(Loop.new())
	loops.append(Loop.new())
	loops.append(Loop.new())


func _physics_process(delta: float) -> void:
	if is_recording:
		loops[index].max_index += 1
		for part in loops[index].parts:
			for property in part.loopable.properties:
				part.recorded_values[property].append(part.object.get(property))
				print("Recorded property " + property + " with value " + str(part.object.get(property)))
				
	for loop in loops:
		if loop.is_ready:
			for part in loops[index].parts:
				for property in part.loopable.properties:
					part.object.set(property, part.recorded_values[property][loop.index])
					print("Played property " + property + " with value " + str(part.recorded_values[property][loop.index]))
					
			loop.index += 1
			if loop.index >= loop.max_index:
				loop.index = 0


func add_loop_object(object: Node) -> void:
	if not is_recording:
		curr_loop_objects.append(object)


func start_recording() -> void:
	is_recording = true
	loops[index] = Loop.new()
	for obj in curr_loop_objects:
		var part = LoopPart.new()
		
		var loopable_node
		for child in obj.get_children():
			if child is Loopable:
				loopable_node = child
		if not loopable_node:
			printerr("Can't find loopable node!")
		
		part.object = obj
		part.loopable = loopable_node
		loops[index].parts.append(part)
	
	# initialize property arrays
	for part in loops[index].parts:
			for property in part.loopable.properties:
				part.recorded_values[property] = []
	
	curr_loop_objects = []
	loops[index].max_index = 0


func stop_recording() -> void:
	is_recording = false
	loops[index].is_ready = true
	
	for part in loops[index].parts:
		if part.loopable.make_afterimage:
			var afterimage = afterimage_path.instantiate()
			part.object.get_parent().add_child(afterimage)
			part.object = afterimage
		part.loopable.begin_playback()


func cancel_loop(loop_index: int) -> void:
	loops[loop_index].is_ready = false
	loops[loop_index].max_index = 0
	loops[loop_index].parts = []
