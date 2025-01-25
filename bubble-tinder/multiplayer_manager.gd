extends Node2D

var peer = ENetMultiplayerPeer.new()
@export var player_ID_scene: PackedScene

var player_one 
var player_two

var current_player_ID = 0

func _on_host_pressed():
	peer.create_server(80)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_add_second_player)
	_add_player()

func _add_second_player(id = 1):
	player_two = id
	print("I've added player: " + str(id))
	player_two = player_ID_scene.instantiate()
	player_two.name = str(id)
	player_two.set_id(id)
	call_deferred("add_child", player_two)
	_verify_has_two_players()
	
func _add_player(id = 1):
	player_one = id
	print("I've added player: " + str(id))
	player_one = player_ID_scene.instantiate()
	player_one.name = str(id)
	player_one.set_id(id)
	call_deferred("add_child", player_one)
	_verify_has_two_players()
	
func _verify_has_two_players():
	if player_one != 0 and player_two != 0:
		print("We have two players now!")
	# add the player authority

func _on_join_pressed():
	peer.create_client("169.254.212.37", 80)
	multiplayer.multiplayer_peer = peer
