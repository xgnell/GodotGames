extends Item

export (PackedScene) onready var weaponType

func BeforeBeEatenEvent(objectEat):
	var addedWeapon = false
	
	var isFull = true
	for i in range(GlobalValues.MAX_WEAPON_CAN_HANDLE):
		if objectEat.WeaponSlot[i] == null:
			isFull = false
			addedWeapon = true
			
			var newWeapon = weaponType.instance()
			newWeapon.position = objectEat.handleWeaponPosition
			
			objectEat.WeaponSlot.insert(i, newWeapon)
			objectEat.WeaponSlot.remove(i + 1)
			
			break
			
	if isFull:
		addedWeapon = true
		
		var newWeapon = weaponType.instance()
		newWeapon.position = objectEat.handleWeaponPosition
		
		objectEat.remove_child(objectEat.handleWeapon)

		objectEat.handleWeapon = newWeapon
		objectEat.WeaponSlot.insert(objectEat.currentWeaponId, newWeapon)
		objectEat.WeaponSlot.remove(objectEat.currentWeaponId + 1)

		objectEat.add_child(newWeapon)

		GlobalSettings.displaySystem.RemakeNumberOfBullets(newWeapon.maxBullets, newWeapon.maxBullets)
	
	if addedWeapon:
		GlobalSettings.displaySystem.UpdateAllWeaponSlot(objectEat)
	
	return addedWeapon
