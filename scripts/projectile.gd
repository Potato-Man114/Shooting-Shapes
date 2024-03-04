extends Area2D
signal leave_screen

var velocity
@export var leave_screen_score = -1


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += velocity * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	leave_screen.emit(leave_screen_score)
	queue_free()


func _on_area_entered(_area):
	queue_free()
