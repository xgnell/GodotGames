extends Control



func _on_buttonPlay_pressed():
	get_tree().change_scene("res://Assets/Scenes/FirstScene.tscn")


func _on_buttonExit_pressed():
	get_tree().quit()
