extends Control

signal newGame
signal levelSelect

func _on_new_game_pressed() -> void:
	newGame.emit()

func _on_level_select_pressed() -> void:
	levelSelect.emit()
