extends Node

@onready var parent = self.owner

var palettes = [
	preload("res://resources/shaders/palette_default.png"),
	preload("res://resources/shaders/palette_blue.png"),
	preload("res://resources/shaders/palette_red.png")
]

func setup_shaders(tower: Node2D) -> void:
	var sh : ShaderMaterial = parent.material
	
	sh.set_shader_parameter("palette_in",palettes[0])
	sh.set_shader_parameter("palette_out",palettes[Global.lvl])
	
	
	var Tsh : ShaderMaterial = tower.material
	Tsh.set_shader_parameter("ScreenWidth",88)
	Tsh.set_shader_parameter("RealScreenWidth",880)
	Tsh.set_shader_parameter("palette_in",palettes[0])
	Tsh.set_shader_parameter("palette_out",palettes[Global.lvl])
	
	tower.get_child(0).update_shaders()
