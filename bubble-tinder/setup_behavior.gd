extends Control

signal has_confirmed_both

@onready var player1_button = $"Player 1/TextureButton/Player 1 Button"
@onready var player2_button = $"Player 2/TextureButton2/Player 2 Button"

func _on_player_confirm():
	if player1_button.player_has_confirmed and player2_button.player_has_confirmed:
		print("HAS CONFIRMED")
		has_confirmed_both.emit()

func check_authority():
	var is_player_one = $"../../../Multiplayer Manager".is_player_one()
	player1_button._check_belongs_to_player(is_player_one)
	player2_button._check_belongs_to_player(is_player_one)
	pass
