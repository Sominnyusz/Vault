extends Node2D

@onready var animator: AnimationPlayer = $Sprite/AnimationPlayer

var speed = randi_range(250, 375)
var impact = false

func _process(delta: float) -> void:
	if not impact:
		position += Vector2.from_angle(rotation) * speed * delta


func _on_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		area.get_parent().takedamage()
		impact = true 
		animator.play("explode")
	if area.is_in_group("projectile"):
		area.get_parent().explode()
		impact = true
		animator.play("explode")
		
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
