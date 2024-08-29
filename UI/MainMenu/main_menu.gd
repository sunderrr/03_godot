class_name PauseMenu
extends Control

@onready var texture_rect: TextureRect = $TextureRect
#@onready var STAGES_MAIN = preload("res://Stages/Main/Main.tscn")

@export var background_enabled: bool = true

func _ready():
	if background_enabled == false:
		texture_rect.hide()
		

func _on_btn_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Stages/Main/Main.tscn")
	#get_tree().change_scene_to_packed(STAGES_MAIN)

func _on_btn_menu_pressed() -> void:
	pass

func _on_btn_exit_pressed() -> void:
	get_tree().quit()


func _on_btn_fullscreen_pressed() -> void:
	if Global.fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:	
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	Global.fullscreen = !Global.fullscreen
