extends State


func Exit():
	pass

func Enter():
	owner.stateLabel.text = owner.CURRSTATE
	print("damn")

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	pass
