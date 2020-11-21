extends Node

var score

func game_over():
	$ScoreTimer.stop()
	$HUD.show_game_over()
	get_tree().call_group("Pociski", "queue_free")

func new_game():
	score = 0
	$FF.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message()

func _on_StartTimer_timeout():
	$ScoreTimer.start()
	$HUD.update_score(score)


func _on_ScoreTimer_timeout():
	score += 1

