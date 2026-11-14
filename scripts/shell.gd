extends Node2D

@export var speed: int = 922

func _process(delta: float) -> void:
	if abs(position[0]) > 500 or abs(position[1]) > 500:
		queue_free()
	else:
		position += transform.x * speed * delta
