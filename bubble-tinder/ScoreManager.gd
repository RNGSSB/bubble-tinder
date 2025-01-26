extends Node2D

var player1score = 0
var player2score = 0

var currentRound = 1

signal on_player_score
# Called when the node enters the scene tree for the first time.
func _ready():
	currentRound = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func add_player_score(id, amt):
	rpc_add_player_score.rpc(id, amt)

@rpc("any_peer", "call_local", "unreliable_ordered")
func rpc_add_player_score(id, amt):
	if multiplayer.is_server() == false:
		return
	if id == 1:
		# This is the server
		player1score += amt
		print("Player 1 has scored!" + str(multiplayer.get_remote_sender_id()))
		print("RECEIVING: " + str(multiplayer.get_unique_id()))
	else:
		player2score += amt
		print("Player 2 has scored!" + str(multiplayer.get_remote_sender_id()))
		print("RECEIVING: " + str(multiplayer.get_unique_id()))
	currentRound += 1
	rpc_synchronize_score.rpc(player1score, player2score, currentRound)
	print("p1: " + str(player1score))
	print("p2: " + str(player2score))
	print("current round: " + str(currentRound))
	CharacterManager.generate_new_prompt()
	on_player_score.emit()
	
@rpc("authority", "call_remote", "unreliable_ordered")
func rpc_synchronize_score(playerone, playertwo, round):
	print("SYNCHRONIZING SCORE, RECEIVING: " + str(multiplayer.get_unique_id()))
	player1score = playerone
	player2score = playertwo
	currentRound = round
