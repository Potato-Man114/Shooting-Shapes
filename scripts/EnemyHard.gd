extends Area2D

signal shoot(x, y);
signal defeat
signal leave_screen

var velocity
var shots_remaining = 0
var screen_size
@export var min_shoot_delay = 0.5
@export var max_shoot_delay = 3
@export var min_change_direction_delay = 1.5
@export var max_change_direction_delay = 5.0
@export var defeat_score = 10
@export var leave_screen_score = -2

# Called when the node enters the scene tree for the first time.
func _ready():
	$ShootTimer.set_wait_time(randf_range(min_shoot_delay, max_shoot_delay))
	$ChangeDirectionTimer.set_wait_time(randf_range(min_change_direction_delay, max_change_direction_delay))
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += velocity * delta
	if (position.y > screen_size.y):
		velocity.y = -velocity.y
		position.y = screen_size.y
	elif (position.y < 0):
		velocity.y = -velocity.y
		position.y = 0

func _on_area_entered(_area):
	defeat.emit(defeat_score)
	$DefeatSoundEffect.playing = true
	$DefeatParticleEffect.emitting = true
	$CollisionShape2D.set_deferred("disabled", true)
	$Sprite2D.hide()
	await $DefeatParticleEffect.finished
	queue_free()
	
	
func _on_shoot_timer_timeout():
	shoot.emit(position.x, position.y)
	$ShootTimer.set_wait_time(randf_range(min_shoot_delay, max_shoot_delay))

func _on_change_direction_timer_timeout():
	velocity.y = -velocity.y
	$ChangeDirectionTimer.set_wait_time(randf_range(min_change_direction_delay, max_change_direction_delay))

func _on_visible_on_screen_notifier_2d_screen_exited():
	leave_screen.emit(leave_screen_score)
	queue_free()
