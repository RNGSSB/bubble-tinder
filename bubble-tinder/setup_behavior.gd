extends Control

signal has_confirmed_both

@onready var player1_button = $"Player 1/TextureButton/Player 1 Button"
@onready var player2_button = $"Player 2/TextureButton2/Player 2 Button"

func _on_player_confirm():
	if player1_button.player_has_confirmed and player2_button.player_has_confirmed:
		has_confirmed_both.emit()

func _on_setup_transitioned() -> void:
	# Has setup, so, check authority for everything.
	## CHECAR AUTORIDAD
	print("IM CHECKING THE AUTHORITY!")
	pass # Replace with function body.
