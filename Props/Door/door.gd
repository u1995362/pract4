extends Area2D

@onready var anim = $AnimatedSprite2D

@export var door_state : state = state.CLOSED

enum state {
	OPEN,
	OPENING,
	CLOSED,
	FINISH
}

var slime: CharacterBody2D = null


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.connect("open", Callable(self, "opening"))
	match door_state:
		state.OPEN:
			anim.play("Open")
			anim.stop()
			anim.frame = 8
		state.OPENING:
			anim.play("Open")
			door_state = state.OPENING
			await anim.animation_finished
			anim.stop()
			door_state = state.OPEN
		state.CLOSED:
			anim.play("Close")

func _process(_delta: float) -> void:
	if slime: 
		slime_try_to_enter()

func open():
	anim.play("Open")
	door_state = state.OPENING
	await anim.animation_finished
	anim.stop()
	door_state = state.OPEN

func _on_body_entered(body: Node2D) -> void:
	if body is Slime:
		slime = body
		slime_try_to_enter()

func _on_body_exited(body: Node2D) -> void:
	if body is Slime:
		slime = null

func slime_try_to_enter() -> void:
	if door_state == state.OPEN:
		door_state = state.FINISH
		slime.queue_free()
		anim.play("Slime_Entering")
		await anim.animation_finished
		Global.next_lvl.emit()
		
