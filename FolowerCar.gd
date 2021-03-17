extends PathFollow2D

signal ChangeCar

var Speed=randi()%200+200

func _process(delta):
	set_offset(get_offset()+Speed*delta)


func _on_AppearTimer_timeout():
	emit_signal("ChangeCar")
	$AppearTimer.start(10)
