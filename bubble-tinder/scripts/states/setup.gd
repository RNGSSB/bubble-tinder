extends State


func Exit():
	pass

func Enter():
	owner.stateLabel.text = owner.CURRSTATE

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	pass
		
func _on_setup_has_confirmed_both() -> void:
	Transitioned.emit(self, "typing")
