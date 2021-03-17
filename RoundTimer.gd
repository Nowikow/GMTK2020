extends Timer

func _process(_delta):
	$TimerText.text=str(int(time_left))
