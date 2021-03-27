extends Node2D
class_name Weapon


# Infos
export (float) onready var attackRate
export (int) onready var weaponRange
export (PackedScene) onready var objectHandle


var direction:=Vector2.RIGHT
var canAttack = true
onready var standardAttackPositionY

#............................... Getter and Setter


#............................... Built-in functions

func _ready():
	# Default values
	if objectHandle == null: objectHandle = get_parent()
	if attackRate == 0.0: attackRate = GlobalValues.weaponDefaultAttackRate
	if weaponRange == 0: weaponRange = GlobalValues.weaponDefaultRange
	
	# Initialize
	standardAttackPositionY = $AttackPosition.position.y


#................................ Custom functions

func Action():
	pass

func SetDirection(dr: Vector2):
	self.direction = dr
	self.rotation_degrees = rad2deg(atan2(dr.y, dr.x))
	
	if self.rotation_degrees > 270: self.rotation_degrees = -90 + self.rotation_degrees - 270
	elif self.rotation_degrees < -90: self.rotation_degrees = 270 - (-90 - self.rotation_degrees)
	
	if self.rotation_degrees > -90 and self.rotation_degrees < 90:
		$Shape.flip_v = false
		$AttackPosition.position.y = standardAttackPositionY
	elif self.rotation_degrees > 90 and self.rotation_degrees < 270:
		$Shape.flip_v = true
		$AttackPosition.position.y = -standardAttackPositionY
