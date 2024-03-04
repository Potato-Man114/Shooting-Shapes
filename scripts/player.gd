extends Area2D
signal hit
signal shoot(x, y)
signal powerup_gained
signal powerup_lost

@export var shot_cooldown_base = 0.3
@export var shot_cooldown_change = -0.075
@export var speed_base = 200
@export var speed_change = 50
@export var player_textures: Array[Texture2D]
@export var invincibility = false
@export var start_position = Vector2.ZERO
@export var max_powerup_level = 3
var powerup_level = 0
var process_input = true
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	set_powerup_level(0)
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (!process_input):
		return
	var velocity = Vector2.ZERO
	var input = Input.get_axis("move_up", "move_down")
	velocity.y += input * (speed_base + (speed_change * powerup_level))

	if Input.is_action_pressed("shoot") and $ShotCooldown.is_stopped():
		shoot_projectile()
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

func _on_area_shape_entered(_area_rid, _area, _area_shape_index, _local_shape_index):
	if (powerup_level > 0):
		lose_powerup()
		return
	if (invincibility):
		return
	$DefeatParticleEffect.emitting = true
	$ExplosionEffect.playing = true
	$DefeatSoundEffect.playing = true
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
	process_input = false
	$Sprite2D.hide()


func start(pos):
	position = pos
	$CollisionShape2D.disabled = false
	set_powerup_level(0)
	$Sprite2D.show()
	process_input = true

func update_shot_cooldown(new_cooldown):
	$ShotCooldown.wait_time = new_cooldown
	
func powerup():
	if (powerup_level < max_powerup_level):
		powerup_gained.emit()
		set_powerup_level(powerup_level + 1)
	
func lose_powerup():
	if (powerup_level > 0):
		Input.start_joy_vibration(0, 0.2, 0.5, 0.1)
		powerup_lost.emit()
		$LosePowerupEffect.emitting = true
		$LosePowerupSoundEffect.playing = true
		set_powerup_level(powerup_level - 1)
		
func shoot_projectile():
	shoot.emit(position.x, position.y)
	$ShotCooldown.start();
	$ShootSoundEffect.playing = true

func set_powerup_level(new_level):
	if (new_level < 0 or new_level > max_powerup_level):
		print("Invalid powerup level %d" % new_level)
		new_level = 0
	powerup_level = new_level
	update_shot_cooldown(shot_cooldown_base + (shot_cooldown_change * powerup_level))
	$Sprite2D.texture = player_textures[powerup_level]
	
