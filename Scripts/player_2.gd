class_name Player
extends CharacterBody2D

var jump_force: float = -500
var speed: float = 200
var friction: float = 20
var accelerate: float = 50
var dir: float = 0.0

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("jump") and not is_on_floor():
		animation.play("Jump")
	elif is_on_floor():
		if dir != 0:
			animation.play("Walk")
		else:
			animation.play("Idle")
	
	facing_direction()
	
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Input.is_action_just_pressed("new_jump") and is_on_floor():
		velocity.y = jump_force
	
	dir = Input.get_axis("new_left", "new_right")
	if dir != 0:
		velocity.x = move_toward(velocity.x, dir * speed, accelerate)
	else:
		velocity.x = move_toward(velocity.x, 0, friction)
	
	move_and_slide()

func facing_direction() -> void:
	if dir < 0:
		animation.flip_h = true
	elif dir > 0:
		animation.flip_h = false
