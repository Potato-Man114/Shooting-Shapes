extends CanvasLayer

signal start_game

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func show_message(text):
	$Message.text = text
	$Message.show()

func show_game_over():
	show_message("GAME OVER -- PLAY AGAIN?")
	$Message.show()
	$StartButton.show()

func update_score(score):
	$ScoreLabel.text = str(score)


func _on_start_buton_pressed():
	$StartButton.hide()
	$Message.hide()
	start_game.emit()


func _on_message_timer_timeout():
	$Message.hide()
