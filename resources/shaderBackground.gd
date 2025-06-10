extends Node2D

@onready var background = $BackgroundSetting


# Called when the node enters the scene tree for the first time.
func update_shaders() -> void:
	var sh : ShaderMaterial = self.owner.material
	var Bsh : ShaderMaterial = background.material
	
	Bsh.set_shader_parameter("palette_in",sh.get_shader_parameter("palette_in"))
	Bsh.set_shader_parameter("palette_out",sh.get_shader_parameter("palette_out"))
	
	for c in background.get_children():
		for child in c.get_children():
			child.material = sh
	
