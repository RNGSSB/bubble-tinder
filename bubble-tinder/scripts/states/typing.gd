extends State
var stupidCheck = false
var timer = 0
var hasNotified = false
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
	if stupidCheck == false and ScoreManager.currentRound == 7:
		timer = owner.frameCounter 
		stupidCheck = true
	
	if ScoreManager.currentRound == 7 and owner.frameCounter == timer + 300:
		ScoreManager.checkFinalRound = true
		if hasNotified == false:
			ScoreManager.request_jajas()
			hasNotified = true
		Transitioned.emit(self, "results")
