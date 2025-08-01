extends Control

signal newGame
signal levelSelect
signal settings

func _on_new_game_pressed() -> void:
	newGame.emit()

func _on_level_select_pressed() -> void:
	levelSelect.emit()


func _on_settings_pressed() -> void:
	settings.emit()
