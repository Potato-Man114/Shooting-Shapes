extends CanvasLayer

signal start_game

# Called when the node enters the scene tree for the first time.
func _ready():
	show_message($Message, "SHOOTING SHAPES!")
	$StartButton.text = "START GAME"
	$SubMessage.text = "W AND S TO MOVE, SPACE TO SHOOT"
	$ScoreLabel.hide()
	$TimeMessage.hide()
	hide_pause_menu()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func show_message(label, text):
	label.text = text
	label.show()

func show_game_over(game_time):
	show_message($Message, "GAME OVER")
	show_message($SubMessage, "SCORE: " + $ScoreLabel.text)
	show_message($TimeMessage, "TIME: " + String.num(game_time, 2))
	$StartButton.text = "PLAY AGAIN"
	$StartButton.show()
	$ScoreLabel.hide()

func update_score(score):
	$ScoreLabel.text = str(score)


func _on_start_buton_pressed():
	$StartButton.hide()
	$Message.hide()
	$SubMessage.hide()
	$TimeMessage.hide()
	$ScoreLabel.show()
	start_game.emit()


func _on_message_timer_timeout():
	$Message.hide()

func show_pause_menu():
	$ResetButton.show()

func hide_pause_menu():
	$ResetButton.hide()
	
func _on_reset_button_pressed():
	hide_pause_menu()
	get_tree().paused = false
	start_game.emit()
