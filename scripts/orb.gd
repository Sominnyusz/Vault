extends Node2D

var speed = 400

func _process(delta: float) -> void:
	position += Vector2.from_angle(rotation) * speed * delta


func _on_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.lives -= 1
		queue_free()
