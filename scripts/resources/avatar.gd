class_name Avatar extends CharacterBody2D


var hp:int = 100


func take_dmg(dmg:int) -> void:
	hp -= dmg
	print(hp)
