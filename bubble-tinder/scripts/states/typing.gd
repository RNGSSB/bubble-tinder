extends State

func Exit():
	pass

func Enter():
	owner.stateLabel.text = owner.CURRSTATE
	print("damn im in typing")
	$"Typing Spawner"._on_start_typing_callback()
	CharacterManager.generate_new_prompt()
func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	if ScoreManager.currentRound == 7:
		Transitioned.emit(self, "results")
