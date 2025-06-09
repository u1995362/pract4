class_name Enemy extends Avatar

const SPEED = 5.0

@onready var rayL: = $RayCast2DL
@onready var rayR: = $RayCast2DR


var direction : int =  1 #Left -1, Right 1

func _physics_process(delta: float) -> void:
	if !rayL.is_colliding():
		direction = 1
		$AnimatedSprite2D.play("walk_right")
	elif !rayR.is_colliding():
		direction = -1
		$AnimatedSprite2D.play("walk_left")
	
	velocity.x = direction * SPEED

	move_and_slide()
