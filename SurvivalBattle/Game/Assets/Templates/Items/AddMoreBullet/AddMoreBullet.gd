extends Item

func BeforeBeEatenEvent(objectEat):
	var objWeapon = objectEat.handleWeapon
	objWeapon.numberOfBullets += 100
	if objWeapon.numberOfBullets > objWeapon.maxBullets:
		objWeapon.numberOfBullets = objWeapon.maxBullets
	return true