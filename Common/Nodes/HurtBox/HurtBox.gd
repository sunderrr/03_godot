@icon("res://Common/Nodes/HurtBox/HurtBox.svg")
class_name HurtBox
extends Area2D


func _init() -> void:
	# The hurtbox should detect hits but not deal them. This variable does that.
	monitorable = false
	# This turns off collision layer bit 1 and turns on bit 2. It's the physics layer we reserve to hurtboxes in this demo.
	#collision_layer = 2

func _ready() -> void:
	connect("area_entered", _on_area_entered)


func _on_area_entered(hitbox: HitBox) -> void:
	print("_on_area_entered")
	if owner.has_method("take_damage"):
		owner.take_damage(hitbox.get_damage())
	if owner.has_method("knock_back"):
		owner.knock_back(hitbox.global_position)
