extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play("indicator")
	rotation = 2*PI - rotation
	await get_tree().create_timer(1).timeout
	queue_free()
