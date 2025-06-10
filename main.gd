extends Node2D

@export var slime: PackedScene = preload("res://Characters/Slime/slime.tscn")
var player : Slime
var section : Node2D
@onready var camera:Camera2D = $Camera2D



@export_range(1,3) var starting_lvl: int = 1
var lvl : int = 0
var lvls = [
	preload("res://Environment/Tower/Sections/tower2.tscn"),
	preload("res://Environment/Tower/Sections/tower2.tscn"),
	preload("res://Environment/Tower/Sections/tower2.tscn")
]

func _ready() -> void:
	lvl = starting_lvl-1
	Global.connect("next_lvl",next_lvl)
	start_lvl()

func next_lvl() -> void:
	lvl += 1
	if lvl < 3:
		section.queue_free()
		start_lvl()

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("retry"):
		restart_lvl()

func start_lvl() -> void:
	
	var lvl = lvls[lvl]
	
	section = lvl.instantiate()
	add_child(section)
	
	#Crear Player i moviment de la camara
	player = slime.instantiate()
	var slimeSpawn : Marker2D = section.get_child(1)
	player.position.x = slimeSpawn.position.x
	player.position.y = slimeSpawn.position.y
	player.velocity = Vector2.ZERO
	
	add_child(player)
	section.set_player(player)
	var r : RemoteTransform2D = RemoteTransform2D.new()
	r.remote_path = camera.get_path()
	player.add_child(r)
	
	$ShaderSetUp.setup_shaders(section)

func restart_lvl() -> void:
	player._reset()
