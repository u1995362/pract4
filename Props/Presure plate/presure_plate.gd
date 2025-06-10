extends StaticBody2D

@onready var anim = $AnimatedSprite2D

func _ready() -> void:
	anim.play("Normal")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body is Slime): 
		Global.emit_pressed()
		anim.play("Pressed")

func _on_area_2d_body_exited(body: Node2D) -> void:
	anim.play("Normal")
