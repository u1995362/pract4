extends CharacterBody3D

@onready var animation_tree:AnimationTree = $Sprite2D/AnimationTree
@onready var animation_state=  animation_tree.get("parameters/playback")

const SPEED : float = 64
const JUMP_DISTANCE : float = 0.08*3
const JUMP_TIME : float = 0.5

var direction: int = 1

const JUMP_SPEED : float = ( 2 * JUMP_DISTANCE ) / ( JUMP_TIME ) 
const GRAVITY : float = ( 2 * JUMP_DISTANCE ) / ( JUMP_TIME * JUMP_TIME ) 


#Coyote
var coyote_frames = 6
var last_floor = false
var coyote = false 
var jumping = false

var spawn_position
func _ready() -> void:
	spawn_position = position
	$CoyoteTimer.wait_time = coyote_frames / 60.0

func _physics_process(delta: float) -> void:
	
	var current_direction = int(Input.get_axis("ui_left", "ui_right"))
	if current_direction: direction = current_direction
	
	jump_controller(delta)
	position_controller(delta)
	update_animation()
	
	move_and_slide()


func update_animation() -> void:
	if not is_on_floor():
		if velocity.y > 0:
			animation_state.travel("Jump")
			animation_tree.set("parameters/Jump/blend_position", direction)
			return
		else:
			animation_state.travel("Fall")
			animation_tree.set("parameters/Fall/blend_position", direction)
			return
	animation_state.travel("Iddle")
	animation_tree.set("parameters/Iddle/blend_position", direction)

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	position = spawn_position

func _on_coyote_timer_timeout():
	coyote = false
	$CoyoteTimer.stop()


func jump_controller(delta: float) -> void:
	if not is_on_floor():
		velocity.y += -GRAVITY * delta
		if !jumping and last_floor and !coyote:
			coyote = true
			last_floor = false
			$CoyoteTimer.start()
	else:
		jumping = false
		last_floor = true
		
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() or coyote):
		velocity.y = JUMP_SPEED
		jumping = true

func position_controller(delta: float) -> void:
	velocity.x = (spawn_position.x - position.x)
	print(velocity)
