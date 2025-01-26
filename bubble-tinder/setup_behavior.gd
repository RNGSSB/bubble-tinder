extends Control

signal has_confirmed_both
signal on_select_character(character: Character)
@onready var player1_button = $"Setup Elements/Player 1/TextureButton/Player 1 Button"
@onready var player2_button = $"Setup Elements/Player 2/TextureButton2/Player 2 Button"

@onready var selected_character : Character
func _on_player_confirm():
	if player1_button.player_has_confirmed and player2_button.player_has_confirmed:
		print("HAS CONFIRMED")
		has_confirmed_both.emit()
		$"Setup Elements".visible = false

func on_setup_start():
	# Generate a character, and fill out the information accordingly.
	if multiplayer.is_server():
		var character = CharacterManager._generate_characters()
		rpc_get_character.rpc(character)

	var is_player_one = $"../Multiplayer Manager".is_player_one()
	player1_button._check_belongs_to_player(is_player_one)
	player2_button._check_belongs_to_player(is_player_one)

@rpc("any_peer", "call_local", "reliable")
func rpc_get_character(chara: int):
	print("CALLING RPC FROM ID: " + str(multiplayer.get_remote_sender_id()))
	selected_character = CharacterManager.character_list[chara]
	on_select_character.emit(selected_character)
