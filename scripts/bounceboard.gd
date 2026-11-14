extends Area2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D



func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		sprite.play("vault")
		if body.player_state != "Jump":
			body.player_state = "Jump"
		if get_parent().name == "Ceiling":
			body.velocity.y = 800
		else:
			body.velocity.x = rad_to_deg(get_parent().rotation) * 30
			body.velocity.y -= 200
