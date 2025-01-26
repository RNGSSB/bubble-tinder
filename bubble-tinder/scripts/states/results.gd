extends State

var has_set_results = false
func Exit():
	pass

func Enter():
	owner.stateLabel.text = owner.CURRSTATE
	print("Results!!!!")
	set_results_finally()

func Update(_delta: float):
	if has_set_results == false:
		if ScoreManager.has_enough_for_results:
			set_results_finally()
			has_set_results = true
	pass

func Physics_Update(delta: float):
	pass


func set_results_finally():
	print("-------------")
	print("I HAVE ENOUGH FOR RESULTS, PLEASE SET APPROPRIATELY")
	AudioManager.jingle.play()
	var win_manager = $"../../PLAY_UI".get_node("Winning Elements")
	if ScoreManager.player1score > ScoreManager.player2score:
		win_manager.set_win_images(1)
		print("Player 1 Wins!!!!!")
	elif ScoreManager.player1score < ScoreManager.player2score:
		win_manager.set_win_images(2)
		print("Player 2 Wins!!!!!")
	elif ScoreManager.player1score <= 0 and ScoreManager.player2score <= 0:
		print("You both kind of suck...")
	elif ScoreManager.player1score == ScoreManager.player2score:
		print("You both kind of suck...")
