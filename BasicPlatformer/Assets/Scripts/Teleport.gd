extends Area2D

func _on_Teleport_body_entered(body):
	if "Player" in body.name:
		get_tree().change_scene("res://Assets/Scenes/Level2.tscn")
