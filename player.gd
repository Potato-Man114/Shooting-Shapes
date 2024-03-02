extends Area2D

@export var speed = 0
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_down"):
		velocity.y += speed
	if Input.is_action_pressed("move_up"):
		velocity.y += -speed
		
	if Input.is_action_pressed("shoot"):
		#TODO: this
		pass
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
