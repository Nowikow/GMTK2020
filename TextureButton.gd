extends TextureButton


func _on_TextureButton_pressed():
	get_tree().change_scene("res://Main.tscn")
	$ClickSound.play()


func _on_TextureButton_mouse_entered():
	$HoverSound.play()

