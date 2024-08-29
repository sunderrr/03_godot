extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sound_1: AudioStreamPlayer2D = $Sound1
@onready var sprite_container: Node2D = $SpriteContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse_position := get_global_mouse_position()
	look_at(mouse_position)
	#position.y = sin(OS.get_ticks_msec() * delta * 0.20) * 10 


func attack1(damage:float) -> void:
	sound_1.pitch_scale = randf_range(1.7, 2.6)
	animation_player.play("slash")
	
