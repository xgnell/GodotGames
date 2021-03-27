extends Area2D
class_name Item

export (float) var selfDestroyTimer

func _ready():
	# Default values
	if selfDestroyTimer == 0.0: selfDestroyTimer = GlobalValues.itemDefaultDestroyTimer
	
	
	# Initialize
	
	$SelfDestroyTimer.wait_time = selfDestroyTimer
	$SelfDestroyTimer.start()


#........................... Custom functions
func BeforeBeEatenEvent(objectEat):
	return true


#........................... Signals handle

func _on_SelfDestroyTimer_timeout():
	queue_free()


func _on_Item_body_entered(body):
	if body is GlobalResources.objPlayer:
		if BeforeBeEatenEvent(body):
			GlobalSettings.soundSystem.PlaySound("PickItem")
			queue_free()
