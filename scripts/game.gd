extends Node2D

@onready var spawn_points: Node2D = $SpawnPoints
@onready var small = preload("res://scenes/smalldrone.tscn")


var layouts = [
	[["small", "small", "small"], [1, 4, 5]],
	[["small", "big", "small"], [1, 6, 7]],
	[["small", "small", "small", "small"], [6, 3, 2, 7]]
]

func _ready() -> void:
	spawnwave()

func spawnwave():
	var layout = randi_range(0, len(layouts) - 1)
	var instance
	for i in range(len(layouts[layout][0])):
		print(layout, "nig", i, "nig", len(layouts[layout][0]))
		match layouts[layout][0][i]:
			"small":
				instance = small.instantiate()
			"big":
				pass
		instance.global_position = spawn_points.get_child(layouts[layout][1][i]).global_position
		get_node("Enemies").add_child(instance)
	
