extends Camera2D

func _process(delta):
	set_position(get_viewport().get_mouse_position())
	
	if Input.is_action_pressed("LeftClick"):
		if zoom>Vector2(0.6,0.6):
			zoom-=Vector2(delta, delta)
	if Input.is_action_pressed("RightClick"):
		if zoom<Vector2(.99, .99):
			zoom+=Vector2(delta, delta)
		
