extends Control

signal newGame

func _on_new_game_pressed() -> void:
	newGame.emit()
