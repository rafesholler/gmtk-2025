extends Control

signal newGame
signal levelSelect
signal settings

func _on_new_game_pressed() -> void:
	$SelectSF.play()
	newGame.emit()

func _on_level_select_pressed() -> void:
	$SelectSF.play()
	levelSelect.emit()

func _on_settings_pressed() -> void:
	$SelectSF.play()
	settings.emit()


func _on_quit_pressed() -> void:
	$SelectSF.play()
	get_tree().quit()
