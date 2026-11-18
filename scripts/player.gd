extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var animator: AnimationPlayer = $AnimationPlayer
@onready var SHOTTY: Node2D = $SHOTTY
@onready var deathscreen = preload("res://scenes/death_screen.tscn")

@export var speed: int = 250
@export var acceleration: int = 100
@export var jump_power: int = 1000
@export var gravity: int = 2700
@export var fall_gravity: int = 2200
@export var max_jumps: int = 2
@export var horizontal: int

var jumps_made: int = 0
var player_state: String = "Idle"
var lives: int = 3
var death: bool = false
var vulnerable: bool = true

func _ready() -> void:
	animator.play("RESET")

func _physics_process(delta: float) -> void:
	velocity.y += getgravity(velocity) * delta
	move_and_slide()
	if not death:
		if lives <= 0:
			death = true
			die()
		
		horizontal = Input.get_axis("move_Left", "move_Right")
		get_child(1).flip_h = SHOTTY.get_child(0).flip_v
	
		var speedincrease = horizontal * acceleration
		if not is_on_floor():
			speedincrease * 0.3
		if horizontal > 0 and velocity.x < speed:
			velocity.x += speedincrease
		if horizontal < 0 and velocity.x > -speed:
			velocity.x += speedincrease
		if horizontal == 0 and is_on_floor():
			velocity.x = 0
			
		velocity.x *= 0 if death else 0.95
		if abs(velocity.x) < 10:
			velocity.x = 0
		
		
	
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
	else:
		sprite.play("Death")
		sprite.flip_h = false


func getgravity(velocity: Vector2):
	if velocity.y < 0:
		return gravity
	return fall_gravity
	
func takedmg():
	if vulnerable:
		vulnerable = false
		animator.play("hit")
		lives -= 1


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	vulnerable = true

func die():
	sprite.play("Death")
	animator.play("death")
	rotation_degrees = 90
	var instance = deathscreen.instantiate()
	instance.global_position = Vector2(0, 0)
	instance.get_node("kills").text = "Total kills: " + str(get_parent().kills)
	get_tree().current_scene.add_child(instance)
