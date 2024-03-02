extends Area2D

signal shoot(x, y);
signal defeat
signal leave_screen

var velocity
@export var min_shoot_delay = 1.0
@export var max_shoot_delay = 3.0
@export var min_shoot_count = 1.0
@export var max_shoot_count = 3.0
var shots_remaining = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$ShootTimer.set_wait_time(randf_range(min_shoot_delay, max_shoot_delay))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += velocity * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	leave_screen.emit()
	queue_free()


func _on_shoot_timer_timeout():
	shots_remaining = randi_range(1, 3);
	$ShootTimer.stop();
	$ShootTimer.set_wait_time(randi_range(min_shoot_delay, max_shoot_delay))
	$BetweenShotTimer.start()

func _on_between_shot_timer_timeout():
	shoot.emit(position.x, position.y);
	shots_remaining -= 1;
	if (shots_remaining == 0):
		$BetweenShotTimer.stop()
		$ShootTimer.start()


func _on_area_entered(area):
	defeat.emit()
	$AudioStreamPlayer2D.playing = true
	$DefeatParticleEffect.emitting = true
	$CollisionShape2D.set_deferred("disabled", true)
	$Sprite2D.hide()
	await $DefeatParticleEffect.finished
	queue_free()
