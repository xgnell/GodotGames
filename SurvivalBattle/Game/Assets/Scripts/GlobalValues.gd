extends Node2D

# ............................ Running values

var Money = 0 setget SetMoney



var wavekilledEnemies = 0


var WeaponList = [
	[GlobalResources.sPistol, 0.5],
	[GlobalResources.sAK47, 0.5]
]
var WeaponRatioList = [0]

# ............................. Default values
### Weapons
const MAX_WEAPON_CAN_HANDLE = 3

const bulletMinDamage = 100
const bulletMinMoveSpeed = 1000

const weaponDefaultAttackRate = 0.5
const weaponDefaultRange = 20

const gunMinAddBulletForce = 1200
const gunDefaultFireDamage = 10
const gunMinBulletPerShot = 1
const gunDefaultNumberOfBullets = 10
var gunDefaultBulletType = GlobalResources.sNormalBullet



### Items
const itemDefaultDestroyTimer = 10



### Characters

var actorDefaultWeapon = GlobalResources.sPistol
const actorMinMoveSpeed = 300
const actorDefaultLife = 100

const enemyDefaultAttacktimer = 3
const enemyDefaultAttackWaitTimer = 2
const enemyMinAttackRange = 700




### Maps
const mapDefaultEnemiesPerWave = 3
const mapDefaultWaitTimeToNextWave = 3
const mapDefaultBoderColor = 0xffffff
const mapDefaultSize = Vector2(2000, 2000)



### Effect
var bulletDefaultExplosionEffect = GlobalResources.effectBulletExplosion
var actorDefaultDieEffect = GlobalResources.effectActorDie

var blinkDefaultFrequency = 5

func SetMoney(value):
	Money = value
	if is_instance_valid(GlobalSettings.displaySystem):
		GlobalSettings.displaySystem.UpdateMoney(Money)


func _ready():
	# Create weapon ratio list
	for id in range(WeaponList.size()):
		var obj = WeaponList[id]
		#var objName = obj[0]
		var objRatio = obj[1]
		
		var parserNumber = int(objRatio * 10)
		
		for j in range(parserNumber):
			WeaponRatioList.append(id)





