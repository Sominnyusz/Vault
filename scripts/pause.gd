extends Control

var pause: bool = false

func _ready() -> void:
	self.visible = false 

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pauseMenu"):
		pausefunc()

func pausefunc():
		pause = !pause
		get_tree().paused = pause
		self.visible = pause
