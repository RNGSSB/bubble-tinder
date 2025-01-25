extends Node2D

var peer = ENetMultiplayerPeer.new()
@export var setup_scene: PackedScene

var player_one = ""
var player_two = ""

func _on_host_pressed():
	peer.create_server(80)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_add_player)
	_add_player()

func _add_player(id = 1):
	if player_one != "":
		player_two = id
	else:
		player_one = id
	print("I've added player: " + id)
	
func _verify_has_two_players():
	if player_one != "" and player_two != "":
		print("We have two players now!")

func _on_join_pressed():
	peer.create_client("169.254.212.37", 80)
	multiplayer.multiplayer_peer = peer
