extends CharacterBody2D

var speed := 60.0
var direction := 1
const WIDTH_LOOP := 56 * 3 

func _physics_process(delta: float) -> void:
	velocity = Vector2(direction * speed, 0)
	move_and_slide()

	if position.x >= Global.midTowerPosition.x + WIDTH_LOOP / 2:
		position.x -= WIDTH_LOOP

	if position.x <= Global.midTowerPosition.x - WIDTH_LOOP / 2:
		position.x += WIDTH_LOOP
