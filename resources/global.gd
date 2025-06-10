extends Node

var midTowerPosition := Vector2(0, 0)

signal next_lvl

var lvls = [
	{
		scene: "res://Environment/Tower/Sections/tower1.tscn",
		slimePos: Vector2(38,100)
	},
	{
		scene: "res://Environment/Tower/Sections/tower2.tscn",
		slimePos: Vector2(38,100)
	},
	{
		scene: "res://Environment/Tower/Sections/tower3.tscn",
		slimePos: Vector2(38,100)
	}
]



signal open

func emit_pressed():
	open.emit()
