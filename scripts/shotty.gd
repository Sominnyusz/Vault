extends Node2D

@onready var sprite: AnimatedSprite2D = $Sprite

func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	rotation_degrees = wrap(rotation_degrees, 0, 360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -1
		position = Vector2(-14, 4)
	else:
		scale.y = 1
		position = Vector2(14, 4)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("shoot"):
		sprite.play("shoot")
