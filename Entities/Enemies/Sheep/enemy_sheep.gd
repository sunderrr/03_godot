extends CharacterBody2D

@export var health_max := 100

var health := health_max
var pushback_force := Vector2.ZERO

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hurt_particle: GPUParticles2D = $HurtParticle
@onready var damage_spawn_point: Marker2D = $DamageSpawnPoint

func take_damage(amount: int) -> void:
	health = max(0, health - amount)
	animation_player.play("hurt")
	#var label := preload("damage_label/DamageLabel.tscn").instance()
	#label.global_position = damage_spawning_point.global_position
	#label.set_damage(amount)
	Global.emit_signal("enemy_hit")
	#add_child(label)


func knock_back(source_position: Vector2) -> void:
	hurt_particle.rotation = get_angle_to(source_position) + PI
	pushback_force = -global_position.direction_to(source_position) * 300


func _physics_process(delta: float) -> void:
	pushback_force = lerp(pushback_force, Vector2.ZERO, delta * 10)
	velocity = pushback_force
	move_and_slide()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
