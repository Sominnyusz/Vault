extends Area2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D



func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if body.player_state != "Jump":
			body.player_state = "Jump"
		body.velocity.y = -800
