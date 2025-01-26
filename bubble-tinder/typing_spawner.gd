extends Node

@export var typing_scene : PackedScene

@onready var player_one_typing_area = $"Player 1 Typing UI"
@onready var player_two_typing_area = $"Player 2 Typing UI2"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_start_typing_callback() -> void:
	_on_start_typing.rpc()
	
@rpc("call_local", "reliable", "any_peer")
func _on_start_typing() -> void:
	var typing = typing_scene.instantiate()
	typing_scene.name = multiplayer.get_unique_id()
	var is_player_one = $"../../../Multiplayer Manager".is_player_one()
	if is_player_one:
		$"Player 1 Typing UI".add_child(typing)
	else:
		$"Player 2 Typing UI2".add_child(typing)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
