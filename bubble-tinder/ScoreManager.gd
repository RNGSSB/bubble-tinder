extends Node2D

var player1score = 0
var player2score = 0

var player_one_jaja : String = ""
var player_two_jaja : String = ""

var currentRound = 1

var checkFinalRound = false

signal on_player_score
signal on_request_jajas
signal on_add_message_chat(id, str)
# Called when the node enters the scene tree for the first time.
func _ready():
	currentRound = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func add_player_msg_to_chat(id, str):
	rpc_add_player_msg.rpc(id, str)
	
func add_player_score(id, amt):
	rpc_add_player_score.rpc(id, amt)

func request_jajas():
	on_request_jajas.emit()

@rpc("any_peer", "call_local", "reliable")
func set_jaja_value(player_id, jaja):
	if is_multiplayer_authority() == false:
		return

	if player_id == 1 and player_one_jaja == "":
		# This is the server
		player_one_jaja = jaja
		print("RECEIVED JAJA FROM: " + str(multiplayer.get_remote_sender_id()) + ", I AM: " + str(multiplayer.get_unique_id()))
	
	elif player_id != 1 and player_two_jaja == "":
		player_two_jaja = jaja
	
	if multiplayer.is_server() == false:
		return

	if player_one_jaja != "" and player_two_jaja != "":
		#Both have been set so score them
		if player_one_jaja.length() > player_two_jaja.length():
			# Player one gets the point
			print("PLAYER ONE WINS THE HAHA MOMENT")
			add_player_score(1, 2)
		else:
			print("PLAYER TWO WINS THE HAHA MOMENT")
			add_player_score(2, 2)

@rpc("any_peer", "call_local", "unreliable_ordered")
func rpc_add_player_msg(id, str):
	print("ADDING MESSAGE TO CHATLOG")
	on_add_message_chat.emit(id, str)
	
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
