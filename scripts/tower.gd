extends Node2D

const TOWER_WIDTH : int = 6 * 11 
const TILE_SIZE : int = 8
const SPEED : int = 8.0

@onready var Player := $"../slime"

@onready var Tower := $Scene/TowerSprites
@onready var innerTower := $Scene/TowerViewport/WallBackground

@onready var Left := $Tower1
@onready var Mid := $Tower2
@onready var Right := $Tower3

var playerX: float

"func _ready() -> void:
	Left.position.x = -TOWER_WIDTH
	Mid.position.x = 0
	Right.position.x = TOWER_WIDTH"

func _physics_process(delta: float) -> void:
	playerX = Player.position.x
	Tower.position.x = playerX
	$TowerOut.position.x =playerX
	if Player.velocity.x != 0:
		innerTower.position.x = lerp(innerTower.position.x,innerTower.position.x + SPEED * sign(-Player.velocity.x), delta*3)
		check_tower_wrap() 
		check_wrap()

func check_tower_wrap() -> void:
	if innerTower.position.x < -TILE_SIZE:
		innerTower.position.x += TILE_SIZE
	elif innerTower.position.x > TILE_SIZE:
		innerTower.position.x -= TILE_SIZE

func check_wrap() -> void:
	if playerX > Mid.position.x + TOWER_WIDTH / 2:
		Left.position.x = Right.position.x + TOWER_WIDTH
		_rotate_right()
	
	elif playerX < Mid.position.x - TOWER_WIDTH / 2:
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
