extends Area2D

export (int) var speed = 30
export (Vector2) var releaseDir = Vector2.RIGHT
export (Vector2) var releasePos = Vector2.ZERO


var velocity = Vector2.ZERO

func _ready():
	self.position = releasePos
	
	if releaseDir.x < 0:
		$Sprite.flip_h = true


func _physics_process(delta):
		
	velocity.x = releaseDir.x * speed
	translate(velocity)
	


func _on_notifierOutofScreen_screen_exited():
	queue_free()
