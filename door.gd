extends Area2D

@onready var anim = $AnimatedSprite2D
var open = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("Close")
	Global.connect("pressed", Callable(self, "opening"))

func opening():
	if not open:
		anim.play("Opening")
		await anim.animation_finished
		anim.play("Open")
		open = true

func _on_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
