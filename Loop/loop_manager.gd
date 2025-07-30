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
			for object in part.loopable.properties:
				for property in part.loopable.properties[object]:
					part.recorded_values[property].append(object.get(property))
					#print("Recorded property " + property + " of object " + object.name + " with value " + str(object.get(property)))
				
	for loop in loops:
		if loop.is_ready:
			for part in loop.parts:
				for object in part.loopable.properties:
					for property in part.loopable.properties[object]:
						object.set(property, part.recorded_values[property][loop.index])
						#print("Played property " + property + " of object " + object.name + " with value " + str(part.recorded_values[property][loop.index]))
					
			loop.index += 1
			if loop.index >= loop.max_index:
				loop.index = 0


func add_loop_object(object: Node) -> void:
	if not is_recording:
		curr_loop_objects.append(object)


func start_recording() -> void:
	is_recording = true
	cancel_loop(index)
	for obj in curr_loop_objects:
		var part = LoopPart.new()
		
		var loopable_node
		for child in obj.get_children():
			if child is Loopable:
				loopable_node = child
		if not loopable_node:
			printerr("Can't find loopable node!")
		
		part.loopable = loopable_node
		loops[index].parts.append(part)
	
	# initialize property arrays
	for part in loops[index].parts:
			for object in part.loopable.properties:
				for property in part.loopable.properties[object]:
					part.recorded_values[property] = []
	
	curr_loop_objects = []
	loops[index].max_index = 0


func stop_recording() -> void:
	is_recording = false
	loops[index].is_ready = true
	
	for part in loops[index].parts:
		if part.loopable.make_afterimage:
			var afterimage = afterimage_path.instantiate()
			for object in part.loopable.properties:
				if object is Player:
					object.get_parent().add_child(afterimage)
					afterimage.modulate = _get_loop_color(index)
			
			part.loopable = afterimage.get_node("Loopable")
		else:
			for object in part.loopable.properties:
				if object is not Player:
					object.modulate = _get_loop_color(index)
		part.loopable.begin_playback()


func cancel_loop(loop_index: int) -> void:
	loops[loop_index].is_ready = false
	loops[loop_index].max_index = 0
	loops[loop_index].index = 0
	for part in loops[loop_index].parts:
		part.loopable.end_playback()
		for object in part.loopable.properties:
			object.modulate = Color(1, 1, 1)
			if object.is_in_group("afterimage"):
				object.call_deferred("queue_free")
		part.recorded_values.clear()
	loops[loop_index].parts = []


func _get_loop_color(loop_index: int) -> Color:
	match loop_index:
		0:
			return Color(1, 0, 0)
		1:
			return Color(0, 1, 0)
		2:
			return Color(0, 0, 1)
	return Color(1, 1, 1)
