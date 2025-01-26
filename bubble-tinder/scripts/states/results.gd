extends State


func Exit():
	pass

func Enter():
	owner.stateLabel.text = owner.CURRSTATE
	print("Results!!!!")
	
	if ScoreManager.player1score > ScoreManager.player2score:
		print("Player 1 Wins!!!!!")
	elif ScoreManager.player1score < ScoreManager.player2score:
		print("Player 2 Wins!!!!!")
	elif ScoreManager.player1score <= 0 and ScoreManager.player2score <= 0:
		print("You both kind of suck...")
	elif ScoreManager.player1score == ScoreManager.player2score:
		print("You both kind of suck...")

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	pass
