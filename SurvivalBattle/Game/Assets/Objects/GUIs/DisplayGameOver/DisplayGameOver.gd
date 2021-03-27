extends CanvasLayer

func _on_buttonPlayAgain_pressed():
	$Control.visible = false
	GlobalSettings.Reset()
	
	get_tree().reload_current_scene()


func _on_buttonBack_pressed():
	get_tree().change_scene(GlobalResources.MainMenuScene)
