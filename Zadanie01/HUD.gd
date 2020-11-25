extends CanvasLayer

signal start_game

func _ready():
	$InfoLabel.hide()
	$EndLabel.hide()
	$Skip.hide()

func show_message_victory():
	$VictoryLabel.show()
	$MessageTimer.start()
	$Panel.show()

func show_message():
	$InfoLabel.show()
	$MessageTimer.start()
	$Panel.show()
	$Skip.show()

func show_message_end():
	$EndLabel.show()
	$MessageTimer.start()
	$Panel.show()

func show_game_over():
	show_message_end()
	yield($MessageTimer, "timeout")
	$StartButton.show()
	$MessageLabel.text = "Przy moście w Sarajewie"
	$MessageLabel.show()
	$Most.show()

func update_score(score):
	$ScoreLabel.text = str(score)

func _on_MessageTimer_timeout():
	$Panel.hide()
	$InfoLabel.hide()
	$EndLabel.hide()
	$Skip.hide()


func _on_StartButton_pressed():
	$StartButton.hide()
	$MessageLabel.hide()
	$Most.hide()
	emit_signal("start_game")
	



func _on_Skip_pressed():
	$Skip.hide()
	$InfoLabel.hide()
	$Panel.hide()

