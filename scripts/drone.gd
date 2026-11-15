extends Node2D

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var animation: AnimationPlayer = $Sprite/AnimationPlayer
@onready var indicator = preload("res://scenes/indicator.tscn")
@onready var orb = preload("res://scenes/orb.tscn")

@export var health: int

var dead: bool = false
var speed: int = 350
var move: bool = false
var direction
var player

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	attackloop()


func attackloop() -> void:
	while not player.death:
		sprite.play("default")
		await get_tree().create_timer(randf_range(3, 5)).timeout
		if player.death:
			break
		sprite.play("attack_launch")
		await get_tree().create_timer(randf_range(0.4, 1)).timeout
	
		look_at(player.global_position)
	
		move = true
		await get_tree().create_timer(randf_range(0.4, 0.8)).timeout
		move = false
		rotation = 0
	
		spawn_orbs(3)
	
	
		attackloop()

func spawn_orbs(orbcount):
	for i in range(orbcount):
		var instance = orb.instantiate()
		instance.global_position = global_position
		instance.look_at(player.global_position)
		instance.rotation += randf_range(-0.2, 0.2)
		
		get_tree().current_scene.add_child(instance)
		await get_tree().create_timer(0.15).timeout

func takedmg(dmg: int):
	
	health -= dmg
	
	indicatorfunc("-" + str(dmg), false)
	
	if health <= 0:
		indicatorfunc("+1 Kill", true)
		animation.play("death")
		dead = true
		
	else:
		animation.play("hurt")
	await get_tree().create_timer(1).timeout
	animation.play("RESET")
	
	if health <= 0:
		get_parent().get_parent().kills += 1
		queue_free()

func indicatorfunc(text, special):
	if not dead:
		var instance = indicator.instantiate()
		instance.get_child(0).text = text
		instance.position = Vector2(position.x + randf_range(-60, 40), position.y + randf_range(-60, 40))
		if special:
			instance.get_child(0).modulate = Color(0.874, 0.718, 0.0, 1.0)
			instance.scale = Vector2(1.4, 1.4)
		
		get_tree().root.add_child(instance)
