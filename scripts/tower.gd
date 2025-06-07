extends Node2D

const TOWER_WIDTH := 56  

@onready var Player := $"../slime"
@onready var Torre1 := $Torre1
@onready var Torre2 := $Torre2
@onready var Torre3 := $Torre3
@onready var enemy := $Falme

var Left
var Mid
var Right

func _ready() -> void:
	Left = Torre1
	Mid = Torre2
	Right = Torre3
	
	Left.position.x = -TOWER_WIDTH
	Mid.position.x = 0
	Right.position.x = TOWER_WIDTH

func _process(delta: float) -> void:
	check_wrap()

func check_wrap() -> void:
	var px = Player.global_position.x
	
	if px > Mid.position.x + TOWER_WIDTH / 2:
		Left.position.x = Right.position.x + TOWER_WIDTH
		_rotate_right()
	
	elif px < Mid.position.x - TOWER_WIDTH / 2:
		Right.position.x = Left.position.x - TOWER_WIDTH
		_rotate_left()

func _rotate_right():
	var temp = Left
	Left = Mid
	Mid = Right
	Right = temp
	Global.midTowerPosition = Mid.global_position

func _rotate_left():
	var temp = Right
	Right = Mid
	Mid = Left
	Left = temp
	Global.midTowerPosition = Mid.global_position
