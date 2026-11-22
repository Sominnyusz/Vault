extends Node2D

@onready var spawn_points: Node2D = $SpawnPoints
@onready var enemy = preload("res://scenes/enemy.tscn")
@onready var killslabel: Label = $GameUI/Kills
@onready var liveslabel: Label = $GameUI/Lives
var player

var kills: int = 0

var layouts = [
	[["normal", "normal", "normal"], [2, 4, 6]],
	[["normal", "big", "normal"], [1, 4, 7]],
	[["normal", "normal", "normal", "normal"], [1, 2, 6, 7]],
	[["normal", "normal", "normal", "normal"], [1, 7, 8, 9]],
	[["normal", "normal", "big", "normal", "normal"], [1, 7, 4, 8, 9]]
]

func _ready() -> void:
	player = get_node("Player")

func _process(delta: float) -> void:
	if not get_node("Enemies").get_children():
		spawnwave()
		await get_tree().create_timer(1).timeout

func spawnwave():
	var layout = randi_range(0, len(layouts) - 1)
	var instance
	for i in range(len(layouts[layout][0])):
		instance = enemy.instantiate()
		match layouts[layout][0][i]:
			"normal":
				instance.health = 300
				instance.orb_count = 3
				instance.orb_speed = 300
			"big":
				instance.health = 750
				instance.orb_count = 4
				instance.orb_speed = 250
				
				instance.scale = Vector2(1.5, 1.5)
				instance.modulate = Color("ffff89ff")
		
		instance.global_position = spawn_points.get_child(layouts[layout][1][i]).global_position
		get_node("Enemies").add_child(instance)


func player_damage():
	liveslabel.text = "Lives: " + str(player.lives)


func kill():
	kills += 1
	killslabel.text = "Kills: " + str(kills)
