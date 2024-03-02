extends Area2D
signal hit
signal shoot(x, y)
signal powerup_gained
signal powerup_lost

@export var speed = 0
@export var powerup_speed = 0
@export var start_position = Vector2.ZERO
@export var shot_cooldown = 0.3
@export var powerup_shot_cooldown = 0.05
@export var player_texture: Texture2D
@export var powerup_player_texture: Texture2D
var powerup_active = false
var screen_size
var process_input = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.texture = player_texture
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (!process_input):
		return
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_down"):
		velocity.y += speed if !powerup_active else powerup_speed
	if Input.is_action_pressed("move_up"):
		velocity.y += -speed if !powerup_active else -powerup_speed

	if Input.is_action_pressed("shoot") and $ShotCooldown.is_stopped():
		shoot.emit(position.x, position.y)
		$ShotCooldown.start();
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	print("here")
	if (powerup_active):
		lose_powerup()
		return
	$DefeatParticleEffect.emitting = true
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
	process_input = false
	$Sprite2D.hide()


func start(pos):
	position = pos
	$CollisionShape2D.disabled = false
	lose_powerup()
	$Sprite2D.show()
	process_input = true

func update_shot_cooldown(new_cooldown):
	$ShotCooldown.wait_time = new_cooldown
	
func powerup():
	if (!powerup_active):
		powerup_active = true
		powerup_gained.emit()
		update_shot_cooldown(powerup_shot_cooldown)
		$Sprite2D.texture = powerup_player_texture
	
func lose_powerup():
	if (powerup_active):
		powerup_active = false
		powerup_lost.emit()
		update_shot_cooldown(shot_cooldown)
		$Sprite2D.texture = player_texture
		$LosePowerupEffect.emitting = true
