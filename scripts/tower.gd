extends Node2D

const TOWER_WIDTH : int = 56  
const TILE_SIZE : int = 8
const SPEED : int = 8.0

@onready var Player := $"../slime"

@onready var Tower := $Scene/Sprite2D
@onready var innerTower := $Scene/SubViewport/WallBackground

@onready var Torre1 := $Torre1
@onready var Torre2 := $Torre2
@onready var Torre3 := $Torre3

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

func _physics_process(delta: float) -> void:
	Tower.position.x = Player.global_position.x
	var direction := -int(Input.get_axis("move_left", "move_right"))
	if direction:
		innerTower.position.x = lerp(innerTower.position.x,innerTower.position.x + direction * SPEED, delta*3)
		check_tower_wrap() 
		check_wrap()

func check_tower_wrap() -> void:
	
	if innerTower.position.x < -TILE_SIZE:
		innerTower.position.x += TILE_SIZE
	elif innerTower.position.x > TILE_SIZE:
		innerTower.position.x -= TILE_SIZE

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
