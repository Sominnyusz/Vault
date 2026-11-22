extends Node2D

@onready var spawn_points: Node2D = $SpawnPoints
@onready var small = preload("res://scenes/smalldrone.tscn")
@onready var big = preload("res://scenes/bigdrone.tscn")

var kills: int = 0

var layouts = [
	[["small", "small", "small"], [2, 4, 6]],
	[["small", "big", "small"], [1, 4, 7]],
	[["small", "small", "small", "small"], [1, 2, 6, 7]],
	[["small", "small", "small", "small"], [1, 7, 8, 9]],
	[["small", "small", "big", "small", "small"], [1, 7, 4, 8, 9]]
]

func _process(delta: float) -> void:
	if not get_node("Enemies").get_children():
		spawnwave()
		await get_tree().create_timer(1).timeout

func spawnwave():
	var layout = randi_range(0, len(layouts) - 1)
	var instance
	for i in range(len(layouts[layout][0])):
		match layouts[layout][0][i]:
			"small":
				instance = small.instantiate()
			"big":
				instance = big.instantiate()
		instance.global_position = spawn_points.get_child(layouts[layout][1][i]).global_position
		get_node("Enemies").add_child(instance)
	
