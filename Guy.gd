extends AnimatedSprite

signal Change

func _on_ChangeTimer_timeout():	
	emit_signal("Change", self)
	$ChangeTimer.start(7)


func _on_Guy_tree_exited():
	if $GuyArea.Type=='Super':
		queue_free()
