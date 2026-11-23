extends Control

@onready var brokenheart = preload("res://assets/heart_broken.png")


func damage(lives):
	var heart = get_child(lives).get_child(0)
	heart.get_child(0).play("break")
	await get_tree().create_timer(0.3).timeout
	heart.texture = brokenheart
