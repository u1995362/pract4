extends Node2D

@export var slime: PackedScene = preload("res://Characters/Slime/slime.tscn")
var player : Slime
var section : Node2D
@onready var camera:Camera2D = $Camera2D
var remoteTransform : RemoteTransform2D 


@export_range(1,3) var starting_lvl: int = 1
var towers = [
	preload("res://Environment/Tower/Sections/tower1.tscn"),
	preload("res://Environment/Tower/Sections/tower2.tscn"),
	preload("res://Environment/Tower/Sections/tower2.tscn"),
	preload("res://Environment/Tower/Sections/tower2.tscn")
]
var presure_plates_x_lvl = [ 0, 1, 7 ]

func _ready() -> void:
	Global.lvl = starting_lvl-1
	Global.connect("next_lvl",next_lvl)
	Global.connect("final_setting",final_setting)
	start_lvl()

func next_lvl() -> void:
	Global.lvl += 1
	if Global.lvl < 3:
		section.queue_free()
		start_lvl()

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("retry"):
		restart_lvl()

func restart_lvl() -> void:
	player._reset()

func start_lvl() -> void:
	section = towers[Global.lvl].instantiate()
	add_child(section)
	
	#Crea Player i moviment de la camara
	player = slime.instantiate()
	var slimeSpawn : Marker2D = section.get_child(1)
	player.position.x = slimeSpawn.position.x
	player.position.y = slimeSpawn.position.y
	add_child(player)
	section.track_player(player)
	remoteTransform = RemoteTransform2D.new()
	remoteTransform.remote_path = camera.get_path()
	player.add_child(remoteTransform)
	$ShaderSetUp.setup_shaders(section)

func final_setting() -> void:
	remoteTransform.queue_free()
	Global.game_over = true

func _process(delta: float) -> void:
	if Global.game_over: 
		game_over_animation(delta)

func game_over_animation(delta: float) -> void:
	camera.position.x = player.position.x
	camera.position.y = lerp(camera.position.y,-180.0,delta)
	
	if camera.position.y > -170.0: return
	var crown = $Crown
	crown.play("default")
	crown.position.x = player.position.x
	crown.position.y = lerp(crown.position.y,-180.0,delta/8)
	
	if crown.position.y < -180.0: return
