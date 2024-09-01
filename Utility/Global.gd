extends Node

var fullscreen: bool = false
var paused: bool = false

func Pause(state:bool) -> void:
	if state == false:
		Engine.time_scale = 1
	else:
		Engine.time_scale = 0;
	paused = state

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



signal enemy_hit
