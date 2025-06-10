extends Node

var midTowerPosition := Vector2(0, 0)

signal pressed
signal entered

func emit_pressed():
	print("HOLA")
	emit_signal("pressed")

func emit_entered():
	emit_signal("entered")
