extends Node2D

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var shell = preload("res://scenes/shell.tscn")
@onready var shellpoint: Marker2D = $ShellPoint

var fddgffgfg

func _physics_process(delta: float) -> void:
	rotation = (get_global_mouse_position() - get_parent().position).angle()
	
	rotation_degrees = wrap(rotation_degrees, 0, 360)
	
	if rotation_degrees > 90 and rotation_degrees < 270:
		sprite.flip_v = true
		position = Vector2(-14, 4)
	else:
		sprite.flip_v = false
		position = Vector2(14, 4)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("shoot") and sprite.animation != "shoot":
		sprite.play("shoot")
		for i in range(3):
			
			var instance = shell.instantiate()
			instance.rotation_degrees = rotation_degrees + -5 * (i-1)
			instance.global_position = shellpoint.global_position
			instance.speed = abs(get_parent().velocity.x) + 722
			get_tree().root.add_child(instance)
		
		get_parent().velocity -= Vector2.from_angle(rotation) * (abs(get_parent().velocity.x) + 422)
		await sprite.animation_finished
		sprite.play("default")
