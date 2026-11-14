extends Node2D

@onready var cloud = preload("res://scenes/cloud.tscn")

func _ready() -> void:
	for i in range(6):
		spawncloud(-450 + i*150)
	cloudcycle()
	
func cloudcycle():
	await get_tree().create_timer(5).timeout
	spawncloud(-480)
	cloudcycle()

func spawncloud(startx: int):
	var instance = cloud.instantiate()
	instance.texture = load("res://assets/cloud" + str(randi_range(1, 2)) + ".png")
	instance.visible = true
	instance.global_position = Vector2(startx, randi_range(-200, 200))
	add_child(instance)
