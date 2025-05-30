extends Node3D

const SPEED := 2.0
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
		rotation.y += direction * SPEED * delta
