extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play("indicator")
	var tween = create_tween().set_pause_mode(Tween.TWEEN_PAUSE_BOUND)
	await tween.tween_interval(1.0).finished
	queue_free()
