extends Actor


var velocity: Vector2
var justCollideWithEnemy = false
var isDie = false

var WeaponSlot = []
var currentWeaponId = 0

func _ready():
	self.position = Vector2(1000, 1000)
	
	for i in range(GlobalValues.MAX_WEAPON_CAN_HANDLE):
		WeaponSlot.append(null)
	
	if handleWeapon != null:
		WeaponSlot.insert(0, self.handleWeapon)
		WeaponSlot.remove(1)
	
	velocity = Vector2.ZERO
	
func _process(delta):
	if not isDie:
		move_and_slide(velocity)
		velocity = Vector2.ZERO
		
		# Limitation
		var currentMapSize = GlobalSettings.currentWorld.get_node("Map").mapSize
		if (self.position.x < 0) or (self.position.x > currentMapSize.x) or (self.position.y < 0) or (self.position.y > currentMapSize.y):
			self.life = 0
			
		if GlobalSettings.activeShake:
			GlobalSettings.activeShake = false
			$Camera2D.shake(0.7, 15, 30)
			
		if justCollideWithEnemy:
			self.modulate = Color(0, 0, 0) if Engine.get_frames_drawn() % GlobalValues.blinkDefaultFrequency == 0 else Color(1, 1, 1)
		else:
			self.modulate = Color(1, 1, 1)
			
		if self.life <= 0:
			isDie = true
			BeforeDie(GlobalSettings.currentWorld)
			self.visible = false
			GlobalSettings.soundSystem.PlaySound("Die")
			yield(get_tree().create_timer(1), "timeout")
			GlobalSettings.isGameOver = true
			queue_free()

#.............................. Getter and Setter
func SetLife(value):
	var offsetValue = life - value
	if offsetValue >=0:
		GlobalSettings.MakeBalloonNotifier(self.global_position, "- " + str(offsetValue))
	else:
		GlobalSettings.MakeBalloonNotifier(self.global_position, "+ " + str(offsetValue))
	life = value
	
	if is_instance_valid(GlobalSettings.displaySystem):
		GlobalSettings.displaySystem.UpdateHealth(life)


#............................... Custom functions

func ChangeWeapon():
	var oldId = currentWeaponId
	
	while (true):
		currentWeaponId += 1
		if currentWeaponId >= GlobalValues.MAX_WEAPON_CAN_HANDLE:
			currentWeaponId = 0

		if WeaponSlot[currentWeaponId] != null:
			GlobalSettings.displaySystem.FadeoutWeapon(handleWeapon.name, oldId)
			
			remove_child(handleWeapon)
			handleWeapon = WeaponSlot[currentWeaponId]
			add_child(handleWeapon)
			# Change Display System
			GlobalSettings.displaySystem.RemakeNumberOfBullets(handleWeapon.maxBullets, handleWeapon.numberOfBullets)
			
			GlobalSettings.displaySystem.HighlightWeapon(handleWeapon.name, currentWeaponId)
			
			break


func SetWeaponDirection(dr: Vector2):
	self.handleWeapon.SetDirection(dr)

func Action():
	if self.handleWeapon.canAttack:
		self.handleWeapon.Action()


func BeforeDie(objCollide):
	
	GlobalSettings.worldCamera.zoom = $Camera2D.zoom
	GlobalSettings.worldCamera.position = $Camera2D.global_position
	
	GlobalSettings.activeShake = true
	
	GlobalSettings.worldCamera.current = true
	
	
	# Effect
	.BeforeDestroyedEvent(objCollide)

#................................ Implements events

func BeforeDestroyedEvent(objCollide):
	
	self.life -= 10
	
	# Shake screen here
	
	if self.life <= 0:
		BeforeDie(objCollide)
		GlobalSettings.isGameOver = true
		
		return true
	else:
		return false



func CollideWithObjectEvent(objCollide):
	if objCollide.collider is GlobalResources.objEnemy:
		justCollideWithEnemy = true
		
		$CollisionShape2D.disabled= true
		$ForWeaponCollision/CollisionShape2D.disabled = true
		
		self.life -= 5
		
		$DamageTimer.start()
		
	return true

#.............................. Signals handle

func _on_DamageTimer_timeout():
	justCollideWithEnemy = false
	$CollisionShape2D.disabled = false
	$ForWeaponCollision/CollisionShape2D.disabled = false

func _on_Enemy_in_range(dir):
	# When enemy in range
	SetWeaponDirection(dir)