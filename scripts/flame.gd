extends CharacterBody2D

var speed := 20.0
var direction := 1

func _physics_process(delta: float) -> void:
	#if dreta:
	#	direction = 1
	#	$AnimatedSprite2D.play("walk_right")
	#elif esquerra:
	#	direction = -1
	#	$AnimatedSprite2D.play("walk_left")
	
	velocity = Vector2(direction * speed, 0)
	move_and_slide()
