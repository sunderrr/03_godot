extends CharacterBody2D

@onready var particles = $GPUParticles2D
@onready var player_sprite: Sprite2D = $PlayerSprite
@onready var dash: Node2D = $Dash
@onready var weapon_sword: Node2D = $WeaponSword


@export var speed: float = 600
@export var accel: float = 120
@export var friction: float = 75

@export var dashSpeed: float = 1950
@export var dashAccel: float = 1200
#@export var useDelta = true
var dashing = false
var can_dash = true
var dashDuration = 0.18
var dashCooldown = 2.0


func _ready():
	pass
	
func _physics_process(delta):
	get_input()
	player_movement(delta)
	
var input = Vector2.ZERO
func get_input():
	input = Input.get_vector("left", "right", "up", "down")
	if Input.is_action_just_pressed("dash") and can_dash and input != Vector2.ZERO:
		#TODO: should still roll if input is ZERO
		dash_execute()
	if Input.is_action_just_pressed("attack1"):
		weapon_sword.attack1(10)
		
		
func dash_execute():
	can_dash = false
	dashing = true
	particles.emitting = true
	dash.start_dash(player_sprite, dashDuration+0.03, input)
	await get_tree().create_timer(dashDuration).timeout
	dash_ended()
	
func dash_ended():
	dashing = false
	particles.emitting = false
	await get_tree().create_timer(dashCooldown).timeout
	can_dash = true
	
func player_movement(delta):
	if dashing == true:
		velocity += (input * dashAccel * delta * 60)
		velocity = velocity.limit_length(dashSpeed)
		#todo: limit by input strength (for controller for gamepad joystick)
	elif input == Vector2.ZERO:
		if velocity.length() > (friction * delta * 60):
			velocity -= velocity.normalized() * (friction * delta * 60)
		else:
			velocity = Vector2.ZERO
	else:
		velocity += (input * accel * delta * 60)
		velocity = velocity.limit_length(speed)
	move_and_slide()

	
