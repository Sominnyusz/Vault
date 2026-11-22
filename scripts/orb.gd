extends Node2D

@onready var animator: AnimationPlayer = $Sprite/AnimationPlayer
@onready var sprite: Sprite2D = $Sprite
@onready var orb_explode_texture = preload("res://assets/orb_explode.png")
@onready var selfarea: Area2D = $Sprite/Area

var speed = randi_range(250, 375)
var impact = false

func _process(delta: float) -> void:
	if not impact:
		position += Vector2.from_angle(rotation) * speed * delta


func _on_area_area_entered(area: Area2D) -> void:
	selfarea.global_position = Vector2(0, 0)
	selfarea.global_position = global_position
	if area.is_in_group("player"):
		area.get_parent().takedmg()
		impact = true 
		animator.play("hit")
		
	if impact and area.is_in_group("Enemy"):
		area.get_parent().takedmg(100)
		
	if impact and area.is_in_group("projectile"):
		var orb = area.get_parent()
		orb = orb.get_parent()
		orb.explodefunc()

func explodefunc():
	impact = true
	sprite.texture = orb_explode_texture
	animator.play("explode")
		
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
