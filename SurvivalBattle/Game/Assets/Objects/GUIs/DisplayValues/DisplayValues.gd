extends CanvasLayer

func RemakeHealth(maxValue, currentValue):
	var healthBar = $Control/DisplayPoints/HealthContainer/CenterContainer/HealthBar
	healthBar.max_value = maxValue
	healthBar.value = currentValue
func UpdateHealth(value):
	var healthBar = $Control/DisplayPoints/HealthContainer/CenterContainer/HealthBar
	healthBar.value = value
	
	
func RemakeNumberOfBullets(maxValue, currentValue):
	var bulletBar = $Control/DisplayPoints/BulletContainer/CenterContainer/BulletBar
	bulletBar.max_value = maxValue
	bulletBar.value = currentValue


func UpdateNumberOfBullets(value):
	var bulletBar = $Control/DisplayPoints/BulletContainer/CenterContainer/BulletBar
	bulletBar.value = value
	

func UpdateMoney(value):
	var moneyInfo = $Control/DisplayMoney/MoneyContainer/CenterContainer/MoneyValue
	moneyInfo.text = "$" + str(value)
	



func GameNotification(message):
	$Control/GameNotifier.text = str(message)
	$Control/GameNotifier.visible = true
	$Control/GameNotifier/delayTimer.start()

func _on_delayTimer_timeout():
	$Control/GameNotifier.visible = false

func UpdateAllWeaponSlot(objPlayer):
	var weaponSlot = $Control/WeaponSlot
	for i in range(GlobalValues.MAX_WEAPON_CAN_HANDLE):
		var Name = "Slot" + str(i)
		if objPlayer.WeaponSlot[i] != null:
			weaponSlot.get_node("Slot" + str(i)).texture = objPlayer.WeaponSlot[i].get_node("Shape").texture
		else:
			weaponSlot.get_node("Slot" + str(i)).texture = null
	
	#var defaultWeaponTexture = objPlayer.WeaponSlot[objPlayer.currentWeaponId].get_node("Shape").texture
	var Name = "Slot" + str(objPlayer.currentWeaponId) 
	weaponSlot.get_node(Name).texture = load("res://Assets/Sprites/Guns/White_" + objPlayer.handleWeapon.name + ".png")

func HighlightWeapon(Name: String, Id: int):
	$Control/WeaponSlot.get_node("Slot" + str(Id)).texture = load("res://Assets/Sprites/Guns/White_" + Name + ".png")
func FadeoutWeapon(Name: String, Id: int):
	$Control/WeaponSlot.get_node("Slot" + str(Id)).texture = load("res://Assets/Sprites/Guns/" + Name + ".png")




