class_name HurtBox extends Area2D

func _ready() -> void:
	connect("body_entered",_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	body.take_dmg(1);
