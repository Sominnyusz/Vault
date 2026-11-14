extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var speed: int = 250
@export var acceleration: int = 100
@export var jump_power: int = 1000
@export var gravity: int = 2700
@export var fall_gravity: int = 2200
@export var max_jumps: int = 2

var jumps_made: int = 0
var player_state: String = "Idle"

func _physics_process(delta: float) -> void:
	
	var horizontal = Input.get_axis("move_Left", "move_Right")
	if horizontal == 1:
		sprite.flip_h = false
	elif horizontal == -1:
		sprite.flip_h = true
	
	var speedincrease = horizontal * acceleration
	if not is_on_floor():
		speedincrease * 0.3
	if horizontal > 0 and velocity.x < speed:
		velocity.x += speedincrease
	if horizontal < 0 and velocity.x > -speed:
		velocity.x += speedincrease
	if horizontal == 0 and is_on_floor():
		velocity.x = 0
		
	velocity.x *= 0.95
	if abs(velocity.x) < 10:
		velocity.x = 0
		
	velocity.y += getgravity(velocity) * delta
	move_and_slide()
	
	if is_on_floor() and is_zero_approx(velocity.x):
		player_state = "Idle"
		jumps_made = 0
	if is_on_floor() and not is_zero_approx(velocity.x):
		player_state = "Run"
		jumps_made = 0
	if velocity.y > 0 and not is_on_floor():
		player_state = "Fall"
	if Input.is_action_just_pressed("jump") and is_on_floor():
		player_state = "Jump"
		jumps_made += 1
		velocity.y = -jump_power
	if Input.is_action_just_pressed("jump") and not is_on_floor():
		player_state = "DJump"
		jumps_made += 1
		if jumps_made <= max_jumps:
			velocity.y = -jump_power
	if Input.is_action_just_released("jump") and velocity.y < 0:
		player_state = "JumpCancel"
		velocity.y = -jump_power / 2
	
	sprite.play(player_state)



func getgravity(velocity: Vector2):
	if velocity.y < 0:
		return gravity
	return fall_gravity
