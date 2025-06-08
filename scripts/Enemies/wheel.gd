class_name Enemy extends Avatar

const SPEED = 5.0

@onready var rayL: = $RayCast2DL
@onready var rayL2: = $RayCast2DL2
@onready var rayR: = $RayCast2DR
@onready var rayR2: = $RayCast2DR2

var direction : int =  1 #Left -1, Right 1

func _physics_process(delta: float) -> void:
	if !rayL.is_colliding() or rayL2.is_colliding():
		direction = 1
		$AnimatedSprite2D.play("walk_right")
	elif !rayR.is_colliding() or rayR2.is_colliding():
		direction = -1
		$AnimatedSprite2D.play("walk_left")
	
	velocity.x = direction * SPEED

	move_and_slide()
