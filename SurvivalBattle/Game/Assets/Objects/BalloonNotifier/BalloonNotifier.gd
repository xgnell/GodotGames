extends Node2D

export (String) var displayText
export (int) var balloonUpSpeed
export (Vector2) var startPosition

var velocity:=Vector2.UP

func _ready():
	self.position = startPosition
	$mainText.text = displayText
	
	velocity *= balloonUpSpeed
	
func _process(delta):
	translate(velocity)
	self.modulate.a -= 0.02


func _on_destroyTimer_timeout():
	queue_free()
