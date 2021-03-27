extends Node2D
class_name Map

# Spawn infos
export (int) onready var enemiesPerWave
export (float) onready var waitTimeToNextWave

# Shape infos
export (Color) onready var boderColor
export (Vector2) onready var mapSize



var isSpawning = true
onready var currentNumberOfEnemies
var currentWave = 1


#................................. Built-in functions

func _draw():
	draw_rect(Rect2(Vector2.ZERO, mapSize), boderColor, false)

func _ready():
	# Default values
	if enemiesPerWave == 0: enemiesPerWave = GlobalValues.mapDefaultEnemiesPerWave
	if waitTimeToNextWave == 0.0: waitTimeToNextWave = GlobalValues.mapDefaultWaitTimeToNextWave
	if boderColor == Color8(0,0,0): boderColor = GlobalValues.mapDefaultBoderColor
	if mapSize == Vector2.ZERO: mapSize = GlobalValues.mapDefaultSize
	
	# Draw boder
	#update()
	
	# Init values
	currentNumberOfEnemies = enemiesPerWave
	
	$WaitTimer.wait_time = waitTimeToNextWave

func _process(delta):
	if isSpawning:
		if currentNumberOfEnemies <= 0 and GlobalValues.wavekilledEnemies == enemiesPerWave:
			isSpawning = false
			
			GlobalSettings.displaySystem.GameNotification("End Wave")
			
			$WaitTimer.start()
			
	else:
		if $WaitTimer.time_left <= 3:
			GlobalSettings.displaySystem.GameNotification("Up comming wave")


#........................................ Custom functions

func CreateEnemiesList():
	var enemiesList = [
		[GlobalResources.sZombie, 1]
	]
	
	return enemiesList

func CreateItemsList():
	var itemsList = [
		[GlobalResources.sIncreaseSpeedItem, 0.5]
	]
	
	return itemsList


#................................ Signals handle

func _on_WaitTimer_timeout():
	currentNumberOfEnemies = enemiesPerWave
	GlobalValues.wavekilledEnemies = 0
	
	isSpawning = true
	currentWave += 1
	
	GlobalSettings.displaySystem.GameNotification("Wave " + str(currentWave))
