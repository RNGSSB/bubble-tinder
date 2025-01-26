extends State


func Exit():
	pass

func Enter():
	owner.stateLabel.text = owner.CURRSTATE
	print("Results!!!!")

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	pass
