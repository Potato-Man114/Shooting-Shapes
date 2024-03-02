extends CanvasLayer

signal start_game

# Called when the node enters the scene tree for the first time.
func _ready():
	show_message($Message, "SHOOTING SHAPES!")
	$SubMessage.hide()
	$StartButton.text = "START GAME"
	$ScoreLabel.hide()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func show_message(label, text):
	label.text = text
	label.show()

func show_game_over():
	show_message($Message, "GAME OVER")
	show_message($SubMessage, "SCORE: " + $ScoreLabel.text)
	$StartButton.text = "PLAY AGAIN"
	$StartButton.show()
	$ScoreLabel.hide()

func update_score(score):
	$ScoreLabel.text = str(score)


func _on_start_buton_pressed():
	$StartButton.hide()
	$Message.hide()
	$SubMessage.hide()
	$ScoreLabel.show()
	start_game.emit()


func _on_message_timer_timeout():
	$Message.hide()
