extends Node2D

const TOWER_WIDTH := 56  # Ajusta este valor al ancho real de tu torre (en píxeles)

@onready var Player := $"../slime"
@onready var Torre1 := $Torre1
@onready var Torre2 := $Torre2
@onready var Torre3 := $Torre3
@onready var enemy := $Falme

var Left
var Mid
var Right

func _ready() -> void:
	# Posiciona las torres al inicio
	Left = Torre1
	Mid = Torre2
	Right = Torre3
	
	Left.position.x = -TOWER_WIDTH
	Mid.position.x = 0
	Right.position.x = TOWER_WIDTH

func _process(delta: float) -> void:
	check_wrap()
	check_enemy_wrap()

func check_wrap() -> void:
	var px = Player.global_position.x
	
	# Si el jugador pasa el borde derecho del Mid
	if px > Mid.position.x + TOWER_WIDTH / 2:
		# Mover la torre Left a la derecha de Right
		Left.position.x = Right.position.x + TOWER_WIDTH
		_rotate_right()
	
	# Si el jugador pasa el borde izquierdo del Mid
	elif px < Mid.position.x - TOWER_WIDTH / 2:
		# Mover la torre Right a la izquierda de Left
		Right.position.x = Left.position.x - TOWER_WIDTH
		_rotate_left()

func check_enemy_wrap():
	# Si el enemigo sale por la derecha, reaparece a la izquierda
	if enemy.global_position.x > TOWER_WIDTH * 1.5:
		enemy.global_position.x -= TOWER_WIDTH * 3
	# Si sale por la izquierda, reaparece a la derecha
	elif enemy.global_position.x < -TOWER_WIDTH * 1.5:
		enemy.global_position.x += TOWER_WIDTH * 3

func _rotate_right():
	var temp = Left
	Left = Mid
	Mid = Right
	Right = temp

func _rotate_left():
	var temp = Right
	Right = Mid
	Mid = Left
	Left = temp
