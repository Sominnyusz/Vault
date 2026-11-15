extends Node2D

@export var speed: int = 922

func _process(delta: float) -> void:
	if abs(position[0]) > 500 or abs(position[1]) > 500:
		queue_free()
	else:
		position += transform.x * speed * delta


func _on_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		area.get_parent().takedmg(int(speed/20))
		queue_free()
