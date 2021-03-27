extends Item

func BeforeBeEatenEvent(objectEat):
	objectEat.life += 30
	return true