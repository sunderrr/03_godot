extends Control

#@onready var in_game_menu: Control = $"."
@onready var in_game_menu = $CanvasLayer
var paused = false



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("exit"):
		pauseMenu()

func pauseMenu():
	if paused:
		in_game_menu.hide()
		Engine.time_scale = 1
	else:
		in_game_menu.show()
		Engine.time_scale = 0;
	paused = !paused


func _on_resume_pressed():
	pauseMenu()


func _on_quit_pressed():
	get_tree().quit()


var fullscreen = false
func _on_fullscreen_pressed():
	if fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:	
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	fullscreen = !fullscreen
