extends Area2D
class_name Bullet

# Infos
export (Vector2) onready var startPosition
export (Vector2) onready var startDirection
export (int) onready var moveSpeed
export (int) onready var Damage

export (PackedScene) onready var fromObject

# Effects
export (PackedScene) onready var ExplosionEffect


### Built-in functions

func _ready():
	# Default value
	if moveSpeed == 0: moveSpeed = GlobalValues.bulletMinMoveSpeed
	if Damage == 0: Damage = GlobalValues.bulletMinDamage
	
	if ExplosionEffect == null: ExplosionEffect = GlobalValues.bulletDefaultExplosionEffect
	
	# Initialize
	self.position = startPosition
	self.rotation_degrees = rad2deg(atan2(startDirection.y, startDirection.x))


func _process(delta):
	translate(startDirection * moveSpeed * delta)

## Custom functions


### Custom events

func BeforeDestroyedEvent():
	# Default effect here
	var explosionEffect = ExplosionEffect.instance()
	explosionEffect.position = self.global_position
	explosionEffect.emitting = true

	GlobalSettings.currentWorld.add_child(explosionEffect)

	
	return true

### Signals handle

func _on_NotifierScreenExit_screen_exited():
	queue_free()


func _on_Bullet_area_entered(area):
	if area != fromObject:
		if not area is GlobalResources.objWeapon:
			if BeforeDestroyedEvent():
				#GlobalSettings.soundSystem.PlaySound("Explosion")
				queue_free()
