extends Node2D

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var animation: AnimationPlayer = $Sprite/AnimationPlayer
@onready var indicator = preload("res://scenes/indicator.tscn")
@onready var orb = preload("res://scenes/orb.tscn")
@onready var hitbox: CollisionShape2D = $Area/Hitbox

@export var health: int
@export var orb_count: int
@export var orb_speed: int

var dead: bool = false
var move: bool = false
var direction
var player
var game
var attacking = true  

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	game = get_parent().get_parent()


func _process(delta: float) -> void:
	attackloop()
	
func attackloop():
	if not player.death and attacking:
		attacking = false
		sprite.play("default")
		await get_tree().create_timer(randf_range(3, 5)).timeout
		
		sprite.play("attack")
		await get_tree().create_timer(randf_range(0.4, 1)).timeout
		
		
		rotate(get_angle_to(player.global_position))
		if rotation_degrees > 90 and rotation_degrees < 270:
			rotation_degrees - 90
			rotation_degrees *= -1
			sprite.flip_h = true
		rotation_degrees /= 5
	
		move = true
		await get_tree().create_timer(randf_range(0.4, 0.8)).timeout
		move = false
		rotation = 0
		
		if not dead:
			spawn_orbs(orb_count)
		
		sprite.play("default")
		sprite.flip_h = false
		await get_tree().create_timer(randf_range(3, 5)).timeout
		attacking = true


func spawn_orbs(orbcount):
	for i in range(orbcount):
		var instance = orb.instantiate()
		instance.global_position = global_position
		instance.look_at(player.global_position)
		instance.rotation += randf_range(-0.2, 0.2)
		instance.speed = orb_speed + randi_range(-25, 25) + game.kills
		
		get_tree().current_scene.add_child(instance)
		await get_tree().create_timer(0.15).timeout

func takedmg(dmg: int):
	health -= dmg
	
	indicatorfunc("-" + str(dmg), false)
	
	if health <= 0:
		indicatorfunc("+1 Kill", true)
		die()
		
	else:
		animation.play("hurt")
	await get_tree().create_timer(0.6).timeout
	if not dead:
		animation.play("RESET")


func indicatorfunc(text, special):
	if not dead:
		var instance = indicator.instantiate()
		instance.get_child(0).text = text
		instance.position = Vector2(position.x + randf_range(-60, 40), position.y + randf_range(-60, 40))
		if special:
			instance.get_child(0).modulate = Color(0.874, 0.718, 0.0, 1.0)
			instance.scale = Vector2(1.4, 1.4)
			
		get_tree().root.add_child(instance)


func die():
	if not dead:
		animation.stop()
		animation.play("death")
		hitbox.disabled = true
		dead = true
		game.kill()
		await get_tree().create_timer(1).timeout
		queue_free()
