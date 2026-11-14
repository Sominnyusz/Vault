extends Sprite2D

var cloudspeed = randf_range(0.4, 0.8)
var scaling = randf_range(0.6, 0.9)

func _physics_process(delta: float) -> void:	
	self.scale = Vector2(scaling, scaling)
	global_position = Vector2(global_position[0]+cloudspeed, global_position[1])
	if global_position[0] > 500:
		queue_free()
