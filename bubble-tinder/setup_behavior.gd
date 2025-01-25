extends Control

signal has_confirmed_both

@onready var player1 = $"Player 1/TextureButton/Player 1 Button"
@onready var player2 = $"Player 2/TextureButton2/Player 2 Button"

func _on_player_confirm():
	if player1.player_has_confirmed and player2.player_has_confirmed:
		has_confirmed_both.emit()
	
