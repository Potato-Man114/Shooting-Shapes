extends Area2D
signal hit

@export var speed = 0
@export var start_position = Vector2.ZERO
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	#position = start_position

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

func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)


func start(pos):
	position = pos
	$CollisionShape2D.disabled = false
	show()

