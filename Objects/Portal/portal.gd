extends Area2D
class_name Portal

@export var disable_inverse = false

# --- Updated Enum with all portal colors ---
enum Colors {
	PURPLE,
	YELLOW,
	RED,
	BLUE,
	GREEN,
	INDIGO,
	ORANGE,
	AQUA,
	GREY,
	NEON_GREEN,
	BROWN,
	BLOOD_ORANGE,
	HOT_PINK
}

# --- Updated Dictionary with new ripple colors ---
var ripple_colors = {
	Colors.PURPLE: Color(0.641, 0.22, 0.613),
	Colors.YELLOW: Color(0.557, 0.729, 0.196),
	Colors.RED: Color(0.827, 0.168, 0.209),
	Colors.BLUE: Color(0.161, 0.525, 0.8),      # #2986cc
	Colors.GREEN: Color(0.416, 0.659, 0.31),     # #6aa84f
	Colors.INDIGO: Color(0.208, 0.11, 0.459),    # #351c75
	Colors.ORANGE: Color(1.0, 0.588, 0.0),       # #ff9600
	Colors.AQUA: Color(0.012, 0.404, 0.49),      # #03677d
	Colors.GREY: Color(1.0, 1.0, 1.0),           # #ffffff
	Colors.NEON_GREEN: Color(0.071, 1.0, 0.027), # #12ff07
	Colors.BROWN: Color(0.455, 0.278, 0.0),      # #744700
	Colors.BLOOD_ORANGE: Color(1.0, 0.51, 0.51),  # #ff8282
	Colors.HOT_PINK: Color(0.871, 0.027, 1.0)
}

@export var color: Colors

# --- Preloading all portal sprites ---
var purple_sprite = preload("res://Objects/Portal/portal_purple.png")
var yellow_sprite = preload("res://Objects/Portal/portal_yellow.png")
var red_sprite = preload("res://Objects/Portal/portal_red.png")
var blue_sprite = preload("res://Objects/Portal/portal_blue.png")
var green_sprite = preload("res://Objects/Portal/portal_green.png")
var indigo_sprite = preload("res://Objects/Portal/portal_indigo.png")
var orange_sprite = preload("res://Objects/Portal/portal_orange.png")
var aqua_sprite = preload("res://Objects/Portal/portal_aqua.png")
var grey_sprite = preload("res://Objects/Portal/portal_grey.png")
var neon_green_sprite = preload("res://Objects/Portal/portal_neon_green.png")
var brown_sprite = preload("res://Objects/Portal/portal_brown.png")
var blood_orange = preload("res://Objects/Portal/portal_blood_orange.png")
var hot_pink = preload("res://Objects/Portal/portal_hot_pink.png")


var pair: Portal = null
var just_teleported = false

func _ready() -> void:
	# Find the paired portal in the scene
	for node in get_parent().get_children():
		if node is Portal and node != self:
			if node.color == color:
				pair = node
	if not pair:
		printerr("Could not find a paired portal (color: " + Colors.keys()[color] + ")")

	# --- Updated match statement to set the correct texture ---
	match color:
		Colors.PURPLE:
			$Sprite2D.texture = purple_sprite
		Colors.YELLOW:
			$Sprite2D.texture = yellow_sprite
		Colors.RED:
			$Sprite2D.texture = red_sprite
		Colors.BLUE:
			$Sprite2D.texture = blue_sprite
		Colors.GREEN:
			$Sprite2D.texture = green_sprite
		Colors.INDIGO:
			$Sprite2D.texture = indigo_sprite
		Colors.ORANGE:
			$Sprite2D.texture = orange_sprite
		Colors.AQUA:
			$Sprite2D.texture = aqua_sprite
		Colors.GREY:
			$Sprite2D.texture = grey_sprite
		Colors.NEON_GREEN:
			$Sprite2D.texture = neon_green_sprite
		Colors.BROWN:
			$Sprite2D.texture = brown_sprite

	# Set the shader parameter for the ripple effect color
	($Sprite2D as Sprite2D).set_instance_shader_parameter("color", ripple_colors[color])


func _on_body_entered(body: Node2D) -> void:
	if not just_teleported:
		# Ensure a pair exists before teleporting
		if not pair: return

		pair.just_teleported = true
		body.position = pair.position
		
		# Invert velocity based on portal orientation
		if abs(int(rotation_degrees) % 360) > 45 and abs(int(rotation_degrees) % 360) < 135 and !disable_inverse:
			body.velocity.y *= -1
		
		# Custom velocity for specific level mechanics (e.g., falling blocks)
		if disable_inverse:
			body.velocity.x = 0
			body.velocity.y = -50
			
		# Play teleport sound with random pitch
		$Sound.pitch_scale = randf_range(1, 1.3)
		$Sound.play()


func _on_body_exited(body: Node2D) -> void:
	just_teleported = false
