extends Node2D

@onready var tower = $Tower

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var sh : ShaderMaterial = self.material
	
	var Tsh : ShaderMaterial = tower.material
	Tsh.set_shader_parameter("ScreenWidth",88)
	Tsh.set_shader_parameter("RealScreenWidth",880)
	Tsh.set_shader_parameter("palette_in",sh.get_shader_parameter("palette_in"))
	Tsh.set_shader_parameter("palette_out",sh.get_shader_parameter("palette_out"))
	
	#tower.get_child(0).update_shaders()
	
	"""for c in background.get_children():
		for child in c.get_children():
			child.material = Ssh"""
	


func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("retry"):
		get_tree().change_scene_to_file("res://scenes/main.tscn")
