extends Node2D

onready var currentWorld
onready var worldCamera
onready var displaySystem
onready var soundSystem

var isGameOver = false
var isGameStarted = false
var activeShake = false

var currentPlatform: String


var Settings = {
	Sound = true
}

func _ready():
	if OS.get_name() in ["Windows", "X11", "OSX"]:
		currentPlatform = "Desktop"
	elif OS.get_name() in ["Android", "IOS"]:
		currentPlatform = "Mobile"


func UpdateCurrentWorld():
	currentWorld = get_tree().current_scene
	displaySystem = currentWorld.get_node("DisplaySystem")
	soundSystem = currentWorld.get_node("SoundSystem")
	soundSystem.Setup()

	worldCamera = currentWorld.get_node("WorldCamera")
	
	
func Reset():
	isGameOver = false
	isGameStarted = false
	GlobalValues.wavekilledEnemies = 0


func MakeBalloonNotifier(startPos:Vector2, dispText:String):
	if is_instance_valid(currentWorld):
		var blN = GlobalResources.balloonNotifier.instance()
		blN.displayText = dispText
		blN.startPosition = startPos - Vector2(0, 50)
		
		currentWorld.add_child(blN)








