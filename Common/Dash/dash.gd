class_name Dash

extends Node2D


#@export var duration: float = 0.2
@export var ghost_interval: float = 0.03
@export var addOffset: Vector2 = Vector2.ZERO

@onready var duration_timer = $DurationTimer
@onready var ghost_timer = $GhostTimer
@onready var dust_trail: GPUParticles2D = $DustTrail
@onready var dust_burst: GPUParticles2D = $DustBurst


const DASH_GHOST = preload("res://Common/Dash/dash_ghost.tscn")
#const GHOST_TRAIL = preload("res://Common/GhostTrail/ghost_trail.tscn")
#var ghost_scene = preload("res://DashGhost.tscn")
#var can_dash = true
var parentSprite:Sprite2D


func start_dash(_parentSprite:Sprite2D, duration: float, direction: Vector2):
	duration_timer.wait_time = duration
	duration_timer.start()
	
	parentSprite = _parentSprite
	parentSprite.material.set_shader_parameter("mix_weight", 0.7)
	parentSprite.material.set_shader_parameter("whiten", true)
	
	ghost_timer.wait_time = ghost_interval
	ghost_timer.start()
	
	dust_trail.restart()
	dust_trail.emitting = true
	
	dust_burst.rotation = (direction *-1).angle()
	dust_burst.restart()
	dust_burst.emitting = true
	instance_ghost()


func instance_ghost():
	var ghost: Sprite2D = DASH_GHOST.instantiate()
	get_parent().get_parent().add_child(ghost)

	ghost.global_position = global_position
	ghost.offset = parentSprite.offset + addOffset
	ghost.scale = parentSprite.scale
	ghost.texture = parentSprite.texture
	ghost.vframes = parentSprite.vframes
	ghost.hframes = parentSprite.hframes
	ghost.frame = parentSprite.frame
	ghost.flip_h = parentSprite.flip_h
	
	
func is_dashing():
	return !duration_timer.is_stopped()


func end_dash():
	parentSprite.material.set_shader_parameter("whiten", false)
	ghost_timer.stop()
	
	#can_dash = false
	#await get_tree().create_timer(dash_delay)
	#can_dash = true



func _on_duration_timer_timeout() -> void:
	end_dash()	


func _on_ghost_timer_timeout() -> void:
	instance_ghost()
	
#
#extends Node2D
#
#
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
