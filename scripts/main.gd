extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var sh : ShaderMaterial = $Tower.material
	sh.set_shader_parameter("ScreenWidth",88)
	sh.set_shader_parameter("RealScreenWidth",880)



func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("retry"):
		get_tree().change_scene_to_file("res://scenes/main.tscn")
