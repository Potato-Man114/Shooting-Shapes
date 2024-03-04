extends Area2D

signal leave_screen
signal collected(score)

var velocity = Vector2(-50, 0)
@export var collected_score_change = 15

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += velocity * delta

func _on_area_entered(_area):
	collected.emit(collected_score_change)
	$CollectedSoundEffect.playing = true
	$Sprite2D.hide() 
	$CollisionShape2D.set_deferred("disabled", true)
	$CollectedParticleEffect.emitting = true
	await $CollectedParticleEffect.finished
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	leave_screen.emit()
	queue_free()
