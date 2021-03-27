extends Weapon
class_name Gun

# Infos
export (int) onready var addBulletForce
export (int) onready var fireDamage
export (int) onready var bulletsPerShot
export (int) onready var maxBullets

onready var numberOfBullets setget SetNumberOfBullets

export (PackedScene) onready var BulletType

# Effects
export (PackedScene) onready var FireEffect


#............................. Getter and Setter
func SetNumberOfBullets(value):
	numberOfBullets = value
	if objectHandle is GlobalResources.objPlayer:
		if is_instance_valid(GlobalSettings.displaySystem):
			GlobalSettings.displaySystem.UpdateNumberOfBullets(value)


#............................. Built-in functions

func _ready():
	if addBulletForce == 0: addBulletForce = GlobalValues.gunMinAddBulletForce
	if fireDamage == 0: fireDamage = GlobalValues.gunDefaultFireDamage
	if bulletsPerShot == 0:  bulletsPerShot = GlobalValues.gunMinBulletPerShot
	if maxBullets == 0: maxBullets = GlobalValues.gunDefaultNumberOfBullets
	numberOfBullets = maxBullets
	
	if BulletType == null: BulletType = GlobalValues.gunDefaultBulletType


#	if objectHandle is GlobalResources.objPlayer:
#		$Shape.texture = ResourceLoader.load("res://Assets/Sprites/Guns/White_" + name + ".png")
#	else:
#		$Shape.texture = ResourceLoader.load("res://Assets/Sprites/Guns/" + name + ".png")


#.............................. Custom functions

func Action():
	if self.canAttack:
		# Add here to modify diretion of many bullets
		for i in range(bulletsPerShot):
			if self.numberOfBullets > 0:
				var bullet = BulletType.instance()
				
				bullet.startPosition = $AttackPosition.global_position
				
				if objectHandle is GlobalResources.objPlayer or objectHandle is GlobalResources.objEnemy:
					bullet.startDirection = self.direction
					
				bullet.Damage = fireDamage
				bullet.moveSpeed = addBulletForce
				
				# Release from object
				bullet.fromObject = objectHandle
				
				# Physics Layer
				
				
				GlobalSettings.currentWorld.add_child(bullet)
				
				GlobalSettings.soundSystem.PlaySound("Shot")
				
				if objectHandle is GlobalResources.objPlayer:
					# Update number of bullets
					self.numberOfBullets -= 1
	
			else:
				break
		
		self.canAttack = false
		
		yield(get_tree().create_timer(self.attackRate), "timeout")
		self.canAttack = true







