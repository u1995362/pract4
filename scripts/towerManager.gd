extends Node2D

const SPEED := 20.0
const TILE_SIZE := 8
const TILES_WIDE := 7
const TOWER_WIDTH := TILE_SIZE * TILES_WIDE  # 56

@onready var Torre1: TileMapLayer = $Torre1
@onready var Torre2: TileMapLayer = $Torre2
@onready var Torre3: TileMapLayer = $Torre3

var Left: TileMapLayer
var Mid: TileMapLayer
var Right: TileMapLayer

func _ready() -> void:
	Left = Torre1
	Mid = Torre2
	Right = Torre3

func _physics_process(delta: float) -> void:
	var direction := -int(Input.get_axis("ui_left", "ui_right"))
	if direction:
		for t in [Left, Mid, Right]:
			t.position.x += direction * SPEED * delta
		check_wrap()

func check_wrap() -> void:
	# Si la torre de la derecha se sale por la izquierda, reubícala al final
	if Right.position.x < 16+8:
		print(Right.position.x)
		Left.position.x = Right.position.x + TOWER_WIDTH
		rotate_parts(true)
	# Si la torre de la izquierda se sale por la derecha, reubícala al principio
	elif Left.position.x > 8:
		print(Left.position.x)
		Right.position.x = Left.position.x - TOWER_WIDTH
		rotate_parts(false)

func rotate_parts(direction: bool) -> void:
	if direction:
		var aux = Left
		Left = Mid
		Mid = Right
		Right = aux
	else:
		var aux = Right
		Right = Mid
		Mid = Left
		Left = aux
