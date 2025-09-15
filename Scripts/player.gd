extends CharacterBody2D

@export var speed : float = 50
@export var jump_force: float = -400

@onready var sprite_2d: Sprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print("ready function dijalankan sekali")\
	
	sprite_2d.modulate = Color.AQUAMARINE
	#sprite_in_inspector.modulate = Color.AQUAMARINE
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# print("dijalankan berulang kali di fungsi process")
	pass

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force
	
	var direction := Input.get_axis("left", "right")
	if direction != 0:
		velocity.x = direction * speed
	else:
		velocity.x = 0
		
	move_and_slide()
