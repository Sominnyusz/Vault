extends Node2D

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var shell = preload("res://scenes/shell.tscn")
@onready var shellpoint: Marker2D = $ShellPoint
@onready var cooldowntimer: Timer = $Cooldown

var chamber: bool = true
var cooldown: bool = false

func _physics_process(delta: float) -> void:
	if not get_parent().death:
		rotation = (get_global_mouse_position() - get_parent().position).angle()
	
		rotation_degrees = wrap(rotation_degrees, 0, 360)
	
		if rotation_degrees > 90 and rotation_degrees < 270:
			sprite.flip_v = true
			position = Vector2(-14, 4)
		else:
			sprite.flip_v = false
			position = Vector2(14, 4)
	else:
		visible = false

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("shoot") and chamber and not cooldown and not get_parent().death:
		sprite.play("shoot")
		chamber = false
		cooldown = true
		cooldowntimer.start()
		for i in range(3):
			var instance = shell.instantiate()
			instance.rotation_degrees = rotation_degrees + -4 * (i-1)
			instance.global_position = shellpoint.global_position
			instance.speed = abs(get_parent().velocity.x) + abs(get_parent().velocity.y)*0.7 + 722
			get_tree().root.add_child(instance)
		
		get_parent().velocity -= Vector2.from_angle(rotation) * (abs(get_parent().velocity.x) + 622)
		await sprite.animation_finished
		sprite.play("default")
		chamber = true
	


func _on_cooldown_timeout() -> void:
	cooldown = false
