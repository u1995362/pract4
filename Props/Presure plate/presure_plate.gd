extends StaticBody2D

@onready var anim = $AnimatedSprite2D

var pressed: bool = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if not pressed and body is Slime: 
		pressed = true
		Global.emit_pressed()
		anim.play("Pressed")
