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





#Duplicacio
#var clone: CharacterBody2D = null
#var is_clone: bool = false
#@export var slime_scene: PackedScene


#Coyote
var coyote_frames = 6
#var last_floor = false
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

func _physics_process(delta: float) -> void:
	#if is_clone: return
	#input_controller(delta)
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

"""
func input_controller(delta: float) -> void:
	movement_controller(delta)

	#if Input.is_action_just_pressed("split") and clone == null:
		#split_controller(delta)
	

func movement_controller(delta: float) -> void:
	velocity.x = 0
	if not is_on_floor():
		var gravity_mod : float = 1
		if Input.is_action_pressed("fall"):
			gravity_mod = FALL_FAST
		elif Input.is_action_pressed("jump"):
			gravity_mod = JUMP_MOON
		velocity.y +=  GRAVITY * gravity_mod * delta
		if !jumping and last_floor and !coyote:
			coyote = true
			last_floor = false
			$CoyoteTimer.start()
	else:
		if jumping:
			jumping = false
			last_floor = true
		if Input.is_action_pressed("fall"):
			crawling = true
		elif crawling: 
			if can_uncrouch():
				crawling = false
		
		
	# Handle movement
	
	var current_direction = int(Input.get_axis("move_left", "move_right"))
	if current_direction: 
		direction = current_direction
		velocity.x = direction * SPEED
	
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and (!crawling or crawling and can_uncrouch()) and (is_on_floor() or coyote):
		velocity.y = JUMP_SPEED
		jumping = true
"""

"""
func split_controller(delta: float) -> void:
	clone = slime_scene.instantiate()
	clone.position = position + Vector2(16, 0)
	clone.is_clone = true # 🔁 Indica que és un clon
	get_parent().add_child(clone)
	sync_clone(delta)

func sync_clone(delta: float) -> void:
	clone.velocity.x = -velocity.x
	
	clone.velocity.y += GRAVITY * delta
	
	if jumping and clone.is_on_floor():
		clone.velocity.y = JUMP_SPEED
	
	clone.move_and_slide()
	
	var clone_anim_tree = clone.get_node("Sprite2D/AnimationTree")
	var clone_anim_state = clone_anim_tree.get("parameters/playback")
	var clone_direction = -direction
	
	if not clone.is_on_floor():
		if clone.velocity.y > 0:
			clone_anim_state.travel("Jump")
			clone_anim_tree.set("parameters/Jump/blend_position", clone_direction)
		else:
			clone_anim_state.travel("Fall")
			clone_anim_tree.set("parameters/Fall/blend_position", clone_direction)
	else:
		clone_anim_state.travel("Iddle")
		clone_anim_tree.set("parameters/Iddle/blend_position", clone_direction)
"""

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
