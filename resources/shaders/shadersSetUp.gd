extends Node2D

var nivellActual

"""
@onready var tower = $Tower
@onready var scene = $Tower/Scene
@onready var background = $Tower/Scene/BackgroundSetting

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var Tsh : ShaderMaterial = tower.material
	Tsh.set_shader_parameter("ScreenWidth",88)
	Tsh.set_shader_parameter("RealScreenWidth",880)
	var Ssh : ShaderMaterial = scene.material
	Ssh.set_shader_parameter("palette_in",Tsh.get_shader_parameter("palette_in"))
	Ssh.set_shader_parameter("palette_out",Tsh.get_shader_parameter("palette_out"))
	for c in background.get_children():
		for child in c.get_children():
			child.material = Ssh
	
	


func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("retry"):
		get_tree().change_scene_to_file("res://scenes/main.tscn")
	"""

func _ready() -> void:
	nivellActual = 1
	Global.torre = nivellActual

func _process(delta: float) -> void:
	if (Global.torre != nivellActual):
		var posicion = get_node("Tower").position
		get_node("Tower").queue_free()
		if(Global.torre == 2):
			get_node("Tower").name = "Torre2"
		elif(Global.torre == 3):
			get_node("Tower").name = "Torre2"
