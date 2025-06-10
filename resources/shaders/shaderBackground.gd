extends Node2D


func update_shaders() -> void:
	var sh : ShaderMaterial = self.owner.material
	var Bsh : ShaderMaterial = $BackgroundSetting.material
	
	Bsh.set_shader_parameter("palette_in",sh.get_shader_parameter("palette_in"))
	Bsh.set_shader_parameter("palette_out",sh.get_shader_parameter("palette_out"))
	
	for c in $BackgroundSetting.get_children():
		for child in c.get_children():
			child.material = Bsh
	
