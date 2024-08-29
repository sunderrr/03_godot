class_name MainMenu
extends Control

@onready var texture_rect: TextureRect = $CanvasLayer/TextureRect
@onready var canvas_layer: CanvasLayer = $CanvasLayer
@export var background_enabled: bool = true

	
func _process(_delta):
	if Input.is_action_just_pressed("exit"):
		pauseMenu()
	
func _ready():
	canvas_layer.hide()
	if background_enabled == false:
		texture_rect.hide()

func _on_btn_resume_pressed() -> void:
	pauseMenu()

func _on_btn_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/MainMenu/main_menu.tscn")
	#et_tree().change_scene_to_packed(MAIN_MENU)


func _on_btn_exit_pressed() -> void:
	get_tree().quit()


func _on_btn_fullscreen_pressed() -> void:
	if Global.fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:	
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	Global.fullscreen = !Global.fullscreen


func pauseMenu():
	if Global.paused:
		canvas_layer.hide()
	else:
		canvas_layer.show()
	Global.Pause(!Global.paused)
