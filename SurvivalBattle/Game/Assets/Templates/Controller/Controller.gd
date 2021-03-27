extends CanvasLayer

onready var ControlObject

var forMobile = true if GlobalSettings.currentPlatform == "Mobile" else false
var attackPressed = false
var changeWeaponPressed = false
var isChangedWeapon = false

func _ready():
	ControlObject = get_parent()
	
	if ControlObject is GlobalResources.objActor:
		set_process(true)
		
		if GlobalSettings.currentPlatform == "Desktop":
			$TouchControllSystem.visible = false
		elif GlobalSettings.currentPlatform == "Mobile":
			$TouchControllSystem.visible = true
		
	set_physics_process(false)
	
func _process(delta):
	if not forMobile:
		DesktopController()
	else:
		MobileController()






func DesktopController():
	# For Desktop Platform

	if Input.is_action_pressed("move_left"):
		ControlObject.moveDirection = Vector2.LEFT
		ControlObject.velocity += ControlObject.moveDirection * ControlObject.moveSpeed
	elif Input.is_action_pressed("move_right"):
		ControlObject.moveDirection = Vector2.RIGHT
		ControlObject.velocity += ControlObject.moveDirection * ControlObject.moveSpeed

	if Input.is_action_pressed("move_up"):
		ControlObject.moveDirection = Vector2.UP
		ControlObject.velocity += ControlObject.moveDirection * ControlObject.moveSpeed
	elif Input.is_action_pressed("move_down"):
		ControlObject.moveDirection = Vector2.DOWN
		ControlObject.velocity += ControlObject.moveDirection * ControlObject.moveSpeed

	if Input.is_action_pressed("attack"):
		ControlObject.Action()
		
	if Input.is_action_just_pressed("change_weapon"):
		ControlObject.ChangeWeapon()
		
	if Input.is_action_just_pressed("escape"):
		get_tree().change_scene(GlobalResources.MainMenuScene)
		
	if Input.is_action_just_pressed("ui_accept"):
		GlobalSettings.MakeBalloonNotifier(ControlObject.global_position, "A" + str(1))

	var mousePosition = ControlObject.get_global_mouse_position()

	ControlObject.SetWeaponDirection((mousePosition - ControlObject.position).normalized())





func MobileController():
	# For Mobile Platform
	
	ControlObject.moveDirection = $TouchControllSystem/ControlJoystick/TouchButton.get_value()
	ControlObject.velocity += ControlObject.moveDirection * ControlObject.moveSpeed
	
	if attackPressed:
		ControlObject.Action()
		
	if changeWeaponPressed:
		if not isChangedWeapon:
			isChangedWeapon = true
			ControlObject.ChangeWeapon()




func _on_AttackButton_pressed():
	attackPressed = true

func _on_AttackButton_released():
	attackPressed = false


func _on_BackButton_pressed():
	get_tree().change_scene(GlobalResources.MainMenuScene)


func _on_ChangeWeaponButton_pressed():
	changeWeaponPressed = true


func _on_ChangeWeaponButton_released():
	changeWeaponPressed = false
	isChangedWeapon = false
