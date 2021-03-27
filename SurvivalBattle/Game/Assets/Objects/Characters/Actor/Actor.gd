extends KinematicBody2D
class_name Actor

### Action properties
export (float) onready var moveSpeed
export (Vector2) onready var moveDirection

export (int) onready var attackRange

### Point properties
export (int) onready var life setget SetLife

### Weapon properties
export (PackedScene) onready var InitWeapon

export (PackedScene) onready var DieEffect


var handleWeaponPosition: Vector2
var handleWeapon


#................................ Built-in functions

func _ready():
	# Default values
	if attackRange == 0: attackRange = GlobalValues.enemyMinAttackRange
	if InitWeapon == null: InitWeapon = GlobalValues.actorDefaultWeapon
	if moveSpeed == 0: moveSpeed = GlobalValues.actorMinMoveSpeed
	if life == 0: life = GlobalValues.actorDefaultLife
	
	if DieEffect == null: DieEffect = GlobalValues.actorDefaultDieEffect
	
	
	# Initialize
	handleWeaponPosition = Vector2.ZERO
	
	handleWeapon = InitWeapon.instance()
	handleWeapon.position = self.handleWeaponPosition
	add_child(handleWeapon)
	

func _process(delta):
	# Collision
	for i in get_slide_count():
		var objCollide = get_slide_collision(i)
		if CollideWithObjectEvent(objCollide):
			break


#............................... Getter and Setter
func SetLife(value):
	life = value


#............................... Custom events

func BeforeDestroyedEvent(objCollide) -> bool:
	var dieEffect = self.DieEffect.instance()
	dieEffect.position = self.global_position
	dieEffect.emitting = true
	
	GlobalSettings.currentWorld.add_child(dieEffect)
	
	return true
	

func CollideWithObjectEvent(objCollide) -> bool:
	return true




#.............................. Signals handle

func _on_ForWeaponCollision_area_entered(area):
	if area is GlobalResources.objBullet:
		if area.fromObject != self:
			if BeforeDestroyedEvent(area):
				GlobalSettings.soundSystem.PlaySound("Die")
				queue_free()
