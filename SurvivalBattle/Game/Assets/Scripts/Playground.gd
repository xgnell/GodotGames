extends Node2D

func _ready():
	GlobalSettings.UpdateCurrentWorld()
	GlobalSettings.Reset()
	
	GlobalSettings.displaySystem.get_node("Control").visible = true
	GlobalSettings.currentWorld.get_node("DisplayGameOver").get_node("Control").visible = false
	
	GlobalSettings.displaySystem.RemakeHealth($Player.life, $Player.life)
	GlobalSettings.displaySystem.RemakeNumberOfBullets($Player.handleWeapon.numberOfBullets, $Player.handleWeapon.numberOfBullets)
	GlobalSettings.displaySystem.UpdateMoney(GlobalValues.Money)
	
	GlobalSettings.displaySystem.GameNotification("Start Game")
	
func _process(delta):
	if GlobalSettings.isGameOver:
		
		GlobalSettings.displaySystem.get_node("Control").visible = false
		GlobalSettings.currentWorld.get_node("DisplayGameOver").get_node("Control").visible = true

func _on_startGameTimer_timeout():
	GlobalSettings.isGameStarted = true
	GlobalSettings.displaySystem.GameNotification("Wave 1")
