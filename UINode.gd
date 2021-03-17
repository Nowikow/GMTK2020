extends Node2D


func _process(_delta):
	$ShootBar.value=$ShootTimer.time_left
