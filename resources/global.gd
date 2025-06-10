extends Node

var midTowerPosition := Vector2(0, 0)
var torre := 1

signal pressed

func emit_pressed():
	print("HOLA")
	emit_signal("pressed")
