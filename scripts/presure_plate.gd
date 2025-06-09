extends StaticBody2D

signal pressed

@onready var anim = $AnimatedSprite2D

func _ready() -> void:
	anim.play("Normal")

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("ENTREA")
	anim.play("Pressed")

func _on_area_2d_body_exited(body: Node2D) -> void:
	anim.play("Normal")
