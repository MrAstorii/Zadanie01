extends Area2D


signal hit







func _on_Area2D_body_entered(body):
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)
