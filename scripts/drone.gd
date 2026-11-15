extends Node2D

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var animation: AnimationPlayer = $Sprite/AnimationPlayer
@onready var indicator = preload("res://scenes/indicator.tscn")

@export var health: int = 300

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	pass

func takedmg(dmg: int):
	
	health -= dmg
	
	var instance = indicator.instantiate()
	instance.get_child(0).text = "-" + str(dmg)
	instance.position = Vector2(randf_range(-60, 40), randf_range(-60, 40))
	add_child(instance)
	
	if health <= 0:
		animation.play("death")
	else:
		animation.play("hurt")
	await get_tree().create_timer(1).timeout
	animation.play("RESET")
	
	if health <= 0:
		queue_free()
