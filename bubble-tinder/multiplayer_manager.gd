extends Node2D

var peer = ENetMultiplayerPeer.new()
@export var player_ID_scene: PackedScene

@export var player_one = null
@export var player_two = null

var current_player_ID = 0

func _on_host_pressed():
	AudioManager.buttonPress.play()
	peer.create_server(80)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_add_second_player)
	_add_player()

func _add_second_player(id = 1):
	if id == 1:
		return
	print("I've added player: " + str(id))
	player_two = player_ID_scene.instantiate()
	player_two.name = str(id)
	player_two.set_id(id)
	call_deferred("add_child", player_two)
	_verify_has_two_players()
	
	
func _add_player(id = 1):
	print("I've added player: " + str(id))
	player_one = player_ID_scene.instantiate()
	player_one.name = str(id)
	player_one.set_id(id)
	call_deferred("add_child", player_one)
	_verify_has_two_players()
	
func _verify_has_two_players():
	if player_one != null and player_two != null:
		print("We have two players now!")
		if multiplayer.is_server():
			$"../StateMachine".rpc("change_state", "Setup")

func _on_join_pressed():
	AudioManager.buttonPress.play()
	peer.create_client("169.254.127.65", 80)
	multiplayer.multiplayer_peer = peer
	print("I am a peer ..." + str(multiplayer.get_unique_id()))

func is_player_one() -> bool:
	return multiplayer.get_unique_id() == 1
