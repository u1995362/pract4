extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var sh : ShaderMaterial = $Tower.material
	print(sh)
	sh.set_shader_parameter("ScreenWidth",88)
	sh.set_shader_parameter("RealScreenWidth",880)
