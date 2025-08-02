extends Area2D
class_name Portal

@export var disable_inverse = false

enum Colors {
	PURPLE,
	YELLOW,
	RED
}

var ripple_colors = {
	Colors.PURPLE: Color(0.641, 0.22, 0.613),
	Colors.YELLOW: Color(0.557, 0.729, 0.196),
	Colors.RED: Color(0.827, 0.168, 0.209),
}

@export var color: Colors

var purple_sprite = preload("res://Objects/Portal/portal_purple.png")
var yellow_sprite = preload("res://Objects/Portal/portal_yellow.png")
var red_sprite = preload("res://Objects/Portal/portal_red.png")

var pair: Portal = null

var just_teleported = false

func _ready() -> void:
	for node in get_parent().get_children():
		if node is Portal and node != self:
			if node.color == color:
				pair = node
	if not pair:
		printerr("Could not find a paired portal (color: " + str(color) + ")")
	
	match color:
		Colors.PURPLE:
			$Sprite2D.texture = purple_sprite
		Colors.YELLOW:
			$Sprite2D.texture = yellow_sprite
		Colors.RED:
			$Sprite2D.texture = red_sprite
	
	($Sprite2D as Sprite2D).set_instance_shader_parameter("color", ripple_colors[color])


func _on_body_entered(body: Node2D) -> void:
	if not just_teleported:
		pair.just_teleported = true
		body.position = pair.position
		if abs(int(rotation_degrees) % 360) > 45 and abs(int(rotation_degrees) % 360) < 135 and !disable_inverse:
			body.velocity.y *= -1
		if disable_inverse: #So that I can make levels with falling blocks
			body.velocity = Vector2.ZERO
		$Sound.pitch_scale = randf_range(1, 1.3)
		$Sound.play()


func _on_body_exited(body: Node2D) -> void:
	just_teleported = false
