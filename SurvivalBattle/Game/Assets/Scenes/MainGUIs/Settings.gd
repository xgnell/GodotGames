extends Control

onready var GeneralTab = $TabContainer/General

func _ready():
	# Initialize
	GeneralTab.get_node("Sound").pressed = GlobalSettings.Settings.Sound

func _on_buttonBack_pressed():
	get_tree().change_scene(GlobalResources.MainMenuScene)


func _on_Sound_pressed():
	GlobalSettings.Settings.Sound = not GlobalSettings.Settings.Sound
