class_name Slime extends Avatar

@onready var animation_tree:AnimationTree = $Sprite2D/AnimationTree
@onready var animation_state=  animation_tree.get("parameters/playback")

@onready var rayCL: RayCast2D = $RayCrouchL
@onready var rayCR: RayCast2D = $RayCrouchR

var direction: int = 1

const SPEED : float = 30.0
const SPEED_JUMPING : float = 30.0
const SPEED_FALLING : float = 30.0
const SPEED_CRAWLING : float = 20.0
const SPEED_DEAD : float = 0.0


const JUMP_DISTANCE : float = 3 * 8
const JUMP_TIME : float = 0.5
const JUMP_IMPULSE : float = ( -2 * JUMP_DISTANCE ) / ( JUMP_TIME ) 
const GRAVITY : float = ( 2 * JUMP_DISTANCE ) / ( JUMP_TIME * JUMP_TIME ) 
const JUMP_MOON : float = 0.8
const FALL_FAST : float = 1.8

#Coyote
var coyote_frames = 6
var coyote = false 

enum state {
	IDDLE,
	JUMPING,
	FALLING,
	CRAWLING,
	DEAD
}
var actual_state : state = state.IDDLE

func _ready() -> void:
	$CoyoteTimer.wait_time = coyote_frames / 60.0
	Global.connect("entered", Callable(self, "entering"))

func _physics_process(delta: float) -> void:
	update_state(delta)
	update_animation()

func update_state(delta: float) -> void:
	match actual_state:
		state.IDDLE:
			if !is_on_floor():
				$CoyoteTimer.start()
				actual_state = state.FALLING
			
			elif Input.is_action_pressed("fall"):
				actual_state = state.CRAWLING
			
			elif Input.is_action_pressed("jump"):
				jump()
				actual_state = state.JUMPING
		
		state.JUMPING:
			jump_handler(delta)
			
			if velocity.y > 0:
				actual_state = state.FALLING
		
		state.FALLING:
			jump_handler(delta)
			
			if is_on_floor():
				coyote = true
				actual_state = state.IDDLE
			
			if Input.is_action_just_pressed("jump") and coyote:
				jump()
				actual_state = state.JUMPING
		
		state.CRAWLING:
			if !is_on_floor():
				$CoyoteTimer.start()
				actual_state = state.FALLING
			elif can_uncrouch():
				if !Input.is_action_pressed("fall"):
					actual_state = state.IDDLE
				elif Input.is_action_pressed("jump"):
					jump()
					actual_state = state.JUMPING
		
		state.DEAD:
			if !is_on_floor():
				velocity.y += GRAVITY * delta
	movement()

func movement() -> void:
	velocity.x = 0
	var current_direction = int(Input.get_axis("move_left", "move_right"))
	if current_direction: 
		direction = current_direction
		var speed: float
		
		match actual_state:
			state.IDDLE:
				speed = SPEED
			state.JUMPING:
				speed = SPEED_JUMPING
			state.FALLING:
				speed = SPEED_FALLING
			state.CRAWLING:
				speed = SPEED_CRAWLING
			state.DEAD:
				speed = SPEED_DEAD
		
		velocity.x = direction * speed
	move_and_slide()

func jump() -> void:
	coyote = false
	velocity.y = JUMP_IMPULSE

func jump_handler(delta: float) -> void:
	var gravity_mod : float = 1
	if Input.is_action_pressed("fall"):
		gravity_mod = FALL_FAST
	elif Input.is_action_pressed("jump"):
		gravity_mod = JUMP_MOON
	velocity.y +=  GRAVITY * gravity_mod * delta

func can_uncrouch() -> bool:
	return !rayCL.is_colliding() and !rayCR.is_colliding()

func update_animation() -> void:
	match actual_state:
		state.IDDLE:
			animation_state.travel("Iddle")
			animation_tree.set("parameters/Iddle/blend_position", direction)
		
		state.JUMPING:
			animation_state.travel("Jump")
			animation_tree.set("parameters/Jump/blend_position", direction)
		
		state.FALLING:
			animation_state.travel("Fall")
			animation_tree.set("parameters/Fall/blend_position", direction)
		
		state.CRAWLING:
			animation_state.travel("Crouch")
			animation_tree.set("parameters/Crouch/blend_position", direction)
		
		state.DEAD:
			animation_state.travel("Dead")
			animation_tree.set("parameters/Dead/blend_position", direction)

func _on_coyote_timer_timeout():
	if !is_on_floor():
		coyote = false
	$CoyoteTimer.stop()

func take_dmg(_dmg:int) -> void:
	actual_state = state.DEAD 

func entering():
	visible = false
	set_process(false)
	set_physics_process(false)
