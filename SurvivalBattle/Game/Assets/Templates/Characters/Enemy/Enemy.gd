extends Actor
class_name Enemy

signal _In_Range(direction)

# Infos

export (float) onready var attackTimer
export (float) onready var attackWaitTimer


onready var aimPosition
var canAttack = false
var canSeeAttackRange = false


#.............................. Built-in functions
func _draw():
	if canSeeAttackRange:
		draw_circle(Vector2.ZERO, attackRange + handleWeapon.weaponRange, Color(0.75, 0.75, 0.75, 0.3))

func _ready():
	# Default values
	if attackTimer == 0.0: attackTimer = GlobalValues.enemyDefaultAttacktimer
	if attackWaitTimer == 0.0: attackWaitTimer = GlobalValues.enemyDefaultAttackWaitTimer
	
	# Initialize
	connect("_In_Range", get_parent().get_node("Player"),"_on_Enemy_in_range")
	
	$attackTime.wait_time = attackTimer
	$attackWaitTime.wait_time = attackWaitTimer
	
	$attackWaitTime.start()

func _process(delta):
	if not GlobalSettings.isGameOver:
		# Follow player
		if GlobalSettings.currentWorld.has_node("Player"):
			aimPosition = GlobalSettings.currentWorld.get_node("Player").position
	else:
		if $changeTargetTimer.time_left <= 0:
			var currentMapSize = GlobalSettings.currentWorld.get_node("Map").mapSize
			aimPosition = Vector2(randi() % int(currentMapSize.x), randi() % int(currentMapSize.y))
			
			$changeTargetTimer.start()
	
	Action()




#.............................. Custom functions

func Action():
	var distanceOffset = aimPosition - self.position
	
	
	# For autoAim
	if GlobalSettings.currentPlatform == "Mobile":
		if get_parent().has_node("Player"):
			if distanceOffset.length() <= get_parent().get_node("Player").attackRange:
				emit_signal("_In_Range", -(distanceOffset.normalized()))
	
	# Move Enemy
	self.moveDirection = distanceOffset.normalized()
	move_and_slide(moveDirection * moveSpeed)
	
	self.handleWeapon.SetDirection(moveDirection)
	
	
	# If in attack range, Enemy can attack
	if distanceOffset.length() <= (attackRange + handleWeapon.weaponRange):
		Attack()

func Attack():
	if canAttack:
		if self.handleWeapon.canAttack:
			self.handleWeapon.Action()

func BeforeDestroyedEvent(objCollide):
	if objCollide.fromObject is GlobalResources.objPlayer:
		# Decrease enemy life
		self.life -= 10
		
		if self.life <= 0:
			# Increase Money and more
			GlobalValues.Money += 10
			
			GlobalValues.wavekilledEnemies += 1
			
			var dieEffect = self.DieEffect.instance()
			
			# Effect
			.BeforeDestroyedEvent(objCollide)
			
			GlobalSettings.activeShake = true
			
			return true
		else:
			return false


#............................ Signals handle

func _on_attackWaitTime_timeout():
	canAttack = true
	$attackTime.start()


func _on_attackTime_timeout():
	canAttack = false
	$attackWaitTime.start()
