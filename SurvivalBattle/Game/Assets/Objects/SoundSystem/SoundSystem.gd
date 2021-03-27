extends Node2D

func Setup():
	var allChildren = get_children()
	for audio in allChildren:
		audio.position = GlobalSettings.currentWorld.get_node("Map").mapSize * 0.5
		audio.max_distance = audio.position.x + 3000

func PlaySound(Name: String):
	if GlobalSettings.Settings.Sound == true:
		match Name:
			"Shot":
				$SoundShot.play()
			"Die":
				$SoundDie.play()
			"PickItem":
				$SoundPickItem.play()
			"Explosion":
				$SoundExplosion.play()
			_:
				pass