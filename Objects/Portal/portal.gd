extends Area2D
class_name Portal

enum Colors {
	BLUE,
	RED,
	YELLOW
}

@export var color: Colors

var pair: Portal = null

var just_teleported = false

func _ready() -> void:
	for node in get_parent().get_children():
		if node is Portal and node != self:
			if node.color == color:
				pair = node
	if not pair:
		printerr("Could not find a paired portal (color: " + str(color) + ")")


func _on_body_entered(body: Node2D) -> void:
	if not just_teleported:
		pair.just_teleported = true
		body.position = pair.position


func _on_body_exited(body: Node2D) -> void:
	just_teleported = false
