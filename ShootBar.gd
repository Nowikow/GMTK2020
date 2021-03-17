extends ProgressBar

func _ready():
	set_process(false)

func _process(_delta):
	value=$ShootTimer.time_left
	max_value=$ShootTimer.time_left
