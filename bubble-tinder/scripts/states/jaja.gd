extends State


func Exit():
	pass

func Enter():
	pass

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	if owner.stateFrame > 300:
		Transitioned.emit(self, "results")
