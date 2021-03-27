extends Node2D


# Spawn infos
export (float) var spawnEnemyDelayTimer
export (float) var spawnItemDelayTimer



onready var mapHandleSpawn

onready var enemiesRatioData = []
onready var itemsRatioData = []

onready var enemiesRatioGenerate = [0]
onready var itemsRatioGenerate = [0]

var canEnemySpawn = true
var canItemSpawn = true



func _ready():
	randomize()
	
	mapHandleSpawn = get_parent()
	
	if mapHandleSpawn is GlobalResources.objMap:
		
		# Init objectList
		enemiesRatioData = mapHandleSpawn.CreateEnemiesList()
		itemsRatioData = mapHandleSpawn.CreateItemsList()
		
		# Generate enemiesRatioGenerate
		enemiesRatioGenerate = GenerateRatioList(enemiesRatioData)
		
		# Generate itemsRatioGenerate
		itemsRatioGenerate = GenerateRatioList(itemsRatioData)
		
		set_process(true)
		
	set_physics_process(false)

func _process(delta):
	if GlobalSettings.isGameStarted:
		if not GlobalSettings.isGameOver:
			if canEnemySpawn:
				SpawnEnemies()
				
			if canItemSpawn:
				SpawnItems()



#............................... Custom functions

func GenerateRatioList(dataList):
	
	var outputRatio = []
	for id in range(dataList.size()):
		var obj = dataList[id]
		#var objName = obj[0]
		var objRatio = obj[1]
		
		var parserNumber = int(objRatio * 10)
		
		for j in range(parserNumber):
			outputRatio.append(id)
	return outputRatio

func SpawnEnemies():
	if mapHandleSpawn.currentNumberOfEnemies > 0:
		# Spawn enemies
		var createObj = enemiesRatioData[enemiesRatioGenerate[randi() % enemiesRatioGenerate.size()]][0]
		var obj = createObj.instance()
		obj.position = Vector2(randi() % int(mapHandleSpawn.mapSize.x), randi() % int(mapHandleSpawn.mapSize.y))
		
		GlobalSettings.currentWorld.add_child(obj)
		
		mapHandleSpawn.currentNumberOfEnemies -= 1
		
		canEnemySpawn = false
		
		yield(get_tree().create_timer(spawnEnemyDelayTimer), "timeout")
		
		canEnemySpawn = true
	
	
func SpawnItems():
	# Spawn items
	var createObj = itemsRatioData[itemsRatioGenerate[randi() % itemsRatioGenerate.size()]][0]
	var obj = createObj.instance()
	
	if obj is GlobalResources.objWeaponItem:
		# Create random weapon
		var createWeapon = GlobalValues.WeaponList[GlobalValues.WeaponRatioList[randi() % GlobalValues.WeaponRatioList.size()]][0]
		obj.weaponType = createWeapon
	
	obj.position = Vector2(randi() % int(mapHandleSpawn.mapSize.x), randi() % int(mapHandleSpawn.mapSize.y))
	
	
	GlobalSettings.currentWorld.add_child_below_node(GlobalSettings.currentWorld.get_node("Map"),obj)
	
	
	canItemSpawn = false
	
	yield(get_tree().create_timer(spawnItemDelayTimer), "timeout")
	
	canItemSpawn = true