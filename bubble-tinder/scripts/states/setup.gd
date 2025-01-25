extends State


func Exit():
	pass

func Enter():
	owner.stateLabel.text = owner.CURRSTATE

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	if owner.stateFrame > 500:
		Transitioned.emit(self, "typing")
