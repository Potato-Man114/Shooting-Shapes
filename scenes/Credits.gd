extends CanvasLayer

signal return_button

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_return_button_pressed():
	return_button.emit()
