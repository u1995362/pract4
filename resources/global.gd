extends Node

var midTowerPosition := Vector2(0, 0)

signal open

func emit_pressed():
	open.emit()
