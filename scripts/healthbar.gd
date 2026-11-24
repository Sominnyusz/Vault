extends Control

@onready var brokenheart = preload("res://assets/heart_broken.png")


func damage(lives):
	var heart = get_child(lives).get_child(0)
	heart.get_child(0).play("break")
	var tween = create_tween().set_pause_mode(Tween.TWEEN_PAUSE_BOUND)
	await tween.tween_interval(0.3).finished
	heart.texture = brokenheart
