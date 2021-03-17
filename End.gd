extends Node2D

func _ready():
	$BG/AnimationPlayer.seek(0)
	yield(get_tree().create_timer(4.7), "timeout")
	$BG/Grade.show()

	match Global.Points:
		1:
			$BG/Grade.set_animation('A')
		2:
			$BG/Grade.set_animation('B')
		3:
			$BG/Grade.set_animation('C')
