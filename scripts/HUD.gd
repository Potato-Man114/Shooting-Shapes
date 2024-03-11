extends CanvasLayer

signal start_game

# Called when the node enters the scene tree for the first time.
func _ready():
	show_message($Message, "SHOOTING SHAPES!")
	$StartButton.text = "START GAME"
	$StartButton.grab_focus()
	$ScoreLabel.hide()
	$SubMessage.hide()
	$TimeMessage.hide()
	$Controls.hide()
	$CreditsButton.show()
	$Credits.hide()
	hide_pause_menu()
	$QuitButton.show()
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
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
	$StartButton.grab_focus()
	$ScoreLabel.hide()
	$QuitButton.show()

func update_score(score):
	$ScoreLabel.text = str(score)


func _on_start_buton_pressed():
	$StartButton.hide()
	$Message.hide()
	$SubMessage.hide()
	$TimeMessage.hide()
	$ScoreLabel.show()
	$ControlsButton.hide()
	$QuitButton.hide()
	$CreditsButton.hide()
	start_game.emit()


func _on_message_timer_timeout():
	$Message.hide()

func show_pause_menu():
	$ResetButton.show()
	$ResetButton.grab_focus()
	$QuitButton2.show()

func hide_pause_menu():
	$ResetButton.hide()
	$QuitButton2.hide()
	
func _on_reset_button_pressed():
	hide_pause_menu()
	get_tree().paused = false
	start_game.emit()


func _on_controls_return_button():
	$Controls.hide()
	$Credits.hide()
	$Message.show()
	$StartButton.show()
	$StartButton.grab_focus()
	$SubMessage.hide()
	$ControlsButton.show()
	$CreditsButton.show()
	$QuitButton.show()


func _on_controls_button_pressed():
	show_controls()
	
func show_controls():
	$ScoreLabel.hide()
	$Message.hide()
	$StartButton.hide()
	$SubMessage.hide()
	$TimeMessage.hide()
	$ResetButton.hide()
	$ControlsButton.hide()
	$QuitButton.hide()
	$Credits.hide()
	$Controls.show()
	$Controls/ReturnButton.grab_focus()
	

func _on_quit_button_pressed():
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit();

	
func show_credits():
	$ScoreLabel.hide()
	$Message.hide()
	$StartButton.hide()
	$SubMessage.hide()
	$TimeMessage.hide()
	$ResetButton.hide()
	$ControlsButton.hide()
	$CreditsButton.hide()
	$QuitButton.hide()
	$Controls.hide()
	$Credits.show()
	$Credits/ReturnButton.grab_focus()


func _on_credits_button_pressed():
	show_credits()
