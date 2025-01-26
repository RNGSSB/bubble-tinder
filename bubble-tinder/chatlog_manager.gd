extends Control

@export var text_message : PackedScene
@export var chatlog_container : VBoxContainer

@export var player_one_tex : Texture2D
@export var player_two_tex : Texture2D
@export var npc_tex : Texture2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ScoreManager.on_add_message_chat.connect(add_chat_message)
	pass # Replace with function body.
	
func add_chat_message(id, string):
	var chat_msg = text_message.instantiate()
	chat_msg.get_node("MarginContainer/RichTextLabel").text = string
	if id == 1:
		chat_msg.get_node("Text Message").texture = player_one_tex
	elif id == 00:
		chat_msg.get_node("Text Message").texture = npc_tex
	else:
		chat_msg.get_node("Text Message").texture = player_two_tex
	#TODO: Change color based on id
	chatlog_container.add_child(chat_msg)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
