extends Control

var flashing := false

func _ready() -> void:
	$Icon.material.set_shader_parameter("alpha_threshold", 1.0)

func _process(delta: float) -> void:
	match LoopManager.index:
		0:
			$Icon.texture = load("res://UI/Loops/logo-pink.png")
		1:
			$Icon.texture = load("res://UI/Loops/logo-yellow.png")
		2:
			$Icon.texture = load("res://UI/Loops/logo-red.png")
	
	if LoopManager.is_recording == true:
		if !flashing:
			$Icon.material.set_shader_parameter("alpha_threshold", 0.0)
			flash_start()
			flashing = true
	else:
		if flashing:
			flash_stop()
			flashing = false
	$Number.text = str(LoopManager.max_loops)

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
	
