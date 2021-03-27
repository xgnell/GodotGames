extends Control




func _on_buttonPlay_pressed():
	get_tree().change_scene(GlobalResources.PlaygroundScene)


func _on_buttonSettings_pressed():
	get_tree().change_scene(GlobalResources.SettingsMenu)


func _on_buttonExit_pressed():
	get_tree().quit()
