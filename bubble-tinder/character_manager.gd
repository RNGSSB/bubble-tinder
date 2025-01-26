extends Node

@export var character_list : Array[Resource]

signal on_prompt_generated(prompt_index : int)
var current_character : Character
var current_prompt : Prompt
var prompt_generated : bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _generate_characters() -> int:
	var character_random = character_list.pick_random()
	# Check if this is accurate
	return character_list.find(character_random, 0)

func _generate_prompt() -> int:
	# TODO: Check if this prompt has been read before, if so, don't play it.
	if multiplayer.is_server() == false:
		return -1
	print("I AM GENERATING A NEW PROMPT: " + str(multiplayer.get_unique_id()))
	var prompt_random = current_character.prompts.pick_random()
	ScoreManager.add_player_msg_to_chat(00, prompt_random.promptText)
	return current_character.prompts.find(prompt_random, 0)

func generate_new_prompt() -> void:
	var index = _generate_prompt()
	on_prompt_generated.emit(index)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
