extends Node

var midTowerPosition := Vector2(0, 0)

var lvl : int = 0
signal next_lvl

var pressed_plates : int = 0
signal open

var game_over : bool = false
signal final_setting

func emit_pressed():
	if lvl < 3:
		pressed_plates -= 1
		open.emit()
