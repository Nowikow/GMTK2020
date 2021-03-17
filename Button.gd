extends Button


func _on_Button_pressed():
	get_tree().change_scene("res://Menu/Menu.tscn")
	$ClickSound.play()


func _on_Button_mouse_entered():
	$HoverSound.play()
