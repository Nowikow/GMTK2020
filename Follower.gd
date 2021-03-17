extends PathFollow2D

var Speed=randi()%200+100

func _process(delta):
	set_offset(get_offset()+Speed*delta)
