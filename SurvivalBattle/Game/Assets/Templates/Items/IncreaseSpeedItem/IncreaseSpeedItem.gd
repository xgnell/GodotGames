extends Item

func BeforeBeEatenEvent(objectEat):
	objectEat.moveSpeed += 50
	return true
