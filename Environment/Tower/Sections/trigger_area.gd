extends Area2D

var activated: bool = false

func _on_body_entered(body: Node2D) -> void:
	if not activated and body is Slime:
		activated = true
		Global.final_setting.emit()
