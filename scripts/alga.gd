extends CharacterBody2D

@onready var animation_tree:AnimationTree = $Sprite2D/AnimationTree
@onready var animation_state=  animation_tree.get("parameters/playback")

var last_direction: int = 1

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var coyote_frames = 6
var last_floor = false
var coyote = false 
var jumping = false

var spawn_position
func _ready() -> void:
	spawn_position = position
	$CoyoteTimer.wait_time = coyote_frames / 60.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		last_floor = true
		jumping = false
	
	if !is_on_floor() and !jumping and last_floor and !coyote:
		coyote = true
		last_floor = false
		$CoyoteTimer.start()
		
	# Handle jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() or coyote):
		velocity.y = JUMP_VELOCITY
		jumping = true
	
	var direction: = int(Input.get_axis("ui_left", "ui_right"))
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	update_animation(direction)


func update_animation(direction: int) -> void:
	if(direction != 0):
		animation_state.travel("Walk")
		animation_tree.set("parameters/Iddle/blend_position", direction)
		animation_tree.set("parameters/Walk/blend_position", direction)
		last_direction = direction
	else:
		animation_state.travel("Iddle")
		animation_tree.set("parameters/Iddle/blend_position", last_direction)



func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	position = spawn_position

func _on_coyote_timer_timeout():
	coyote = false
	$CoyoteTimer.stop()
