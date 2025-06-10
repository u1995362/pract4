class_name Flame extends Avatar

@onready var anim = $AnimatedSprite2D

var speed := 60.0
var distancia := 0.0
var direction := 1
const WIDTH_LOOP := 56 * 3 

var is_waiting := false
var wait_time := 0.0
const PAUSE_DURATION := 2.0

func _ready() -> void:
	anim.play("Walk_right")

func _physics_process(delta: float) -> void:
	if is_waiting:
		wait_time -= delta
		if wait_time <= 0:
			is_waiting = false
			direction *= -1
			_play_walk_animation()
		return 
	
	distancia += speed * delta
	print(distancia)
	velocity = Vector2(direction * speed, 0)
	move_and_slide()
	
	if position.x >= Global.midTowerPosition.x + WIDTH_LOOP / 2:
		position.x -= WIDTH_LOOP
		
	if position.x <= Global.midTowerPosition.x - WIDTH_LOOP / 2:
		position.x += WIDTH_LOOP
	
	if distancia >= WIDTH_LOOP:
		is_waiting = true
		wait_time = PAUSE_DURATION
		velocity = Vector2.ZERO 
		distancia = 0
		anim.play("Idle")

func _play_walk_animation():
	if direction == 1:
		anim.play("Walk_right")
	elif direction == -1:
		anim.play("Walk_left")
