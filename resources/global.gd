extends Node

var midTowerPosition := Vector2(0, 0)

signal next_lvl

signal open

func emit_pressed():
	open.emit()
