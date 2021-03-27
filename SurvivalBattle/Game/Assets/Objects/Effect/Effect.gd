extends CPUParticles2D
class_name Effect


func _on_destroyTimer_timeout():
	queue_free()
