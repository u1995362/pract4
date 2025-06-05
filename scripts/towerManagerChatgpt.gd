extends Node2D

const SPEED := 20
const CURVE_AMPLITUDE := 16

@onready var Torre := $CanvasLayer/SubViewport/Background
@onready var screen_width := 88

func _physics_process(delta):
	var input_dir := Input.get_axis("ui_left", "ui_right")
	if input_dir != 0:
		Torre.position.x += input_dir * -SPEED * delta
		# Scroll infinito si quieres (puedes omitir si no hace falta)
		var width  = 16
		if Torre.position.x < -width:
			Torre.position.x += width
		elif Torre.position.x > width:
			Torre.position.x -= width
