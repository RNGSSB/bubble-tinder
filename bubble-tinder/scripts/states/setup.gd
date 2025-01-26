extends State

func Exit():
	pass


func Enter():
	owner.stateLabel.text = owner.CURRSTATE
	# Start checking authority for the setup buttons
	print("IM CHECKING THE AUTHORITY!")
	$"../SETUP".visible = true
	$"../SETUP".check_authority()
	

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	pass
		
func _on_setup_has_confirmed_both() -> void:
	_transition_to_typing.rpc()

@rpc("call_local", "reliable", "any_peer")
func _transition_to_typing():
	print("HAS TRNASITIONED TO THE TYPING STATE")
	Transitioned.emit(self, "typing")
