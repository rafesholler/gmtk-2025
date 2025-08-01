extends Control

var flashing := false
var active_loops = 0

func _ready() -> void:
	if WorldManager.current_room == "res://Menu/Title.tscn":
		visible=false
	else:
		visible=true
	WorldManager.connect("load_next_room", Callable(self,"_on_next_room"));
	$Icon.material.set_shader_parameter("alpha_threshold", 1.0)

func _process(delta: float) -> void:
	if LoopManager.is_recording == true:
		if !flashing:
			$Icon.material.set_shader_parameter("alpha_threshold", 0.0)
			flash_start()
			flashing = true
	else:
		if flashing:
			flash_stop()
			flashing = false
	active_loops = 0
	for loop in LoopManager.loops:
		if loop.is_ready:
			active_loops += 1
	$Number.text = str(3 - active_loops)

func _on_flash_timeout() -> void:
	if $Icon.material.get_shader_parameter("alpha_threshold") == 1.0:
		$Icon.material.set_shader_parameter("alpha_threshold", 0.0)
		$Flash.start()
	elif $Icon.material.get_shader_parameter("alpha_threshold") == 0.0:
		$Icon.material.set_shader_parameter("alpha_threshold", 1.0)
		$Flash.start()
		
func flash_stop():
	$Flash.stop()
	$Icon.material.set_shader_parameter("alpha_threshold", 1.0)

func flash_start():
	$Flash.start()

func _on_next_room():
	if WorldManager.current_room == "res://Menu/Title.tscn":
		visible=false
	elif WorldManager.current_room == "res://Menu/LevelSelect.tscn":
		visible=false
	else:
		visible=true
	
