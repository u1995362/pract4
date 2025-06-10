extends Node

var midTowerPosition := Vector2(0, 0)
var torre := 1

signal open

func emit_pressed():
	open.emit()
