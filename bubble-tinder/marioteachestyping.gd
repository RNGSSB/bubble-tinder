extends Node2D

@onready var playerText = $LineEdit
@onready var labelAwesome = $EpicLabel
@onready var currentCharacter = $Character
@onready var answer1 = $Answer1
@onready var answer2 = $Answer2
@onready var answer3 = $Answer3
@onready var displayPrompt = $displayPrompt
@export var currentPrompt = 0
var prompt = "Select an answer"
var promptTrait = Traits.Traits.FLIRTY
var isJaja = false



func _enter_tree():
	set_multiplayer_authority(name.to_int())

# Called when the node enters the scene tree for the first time.
func _ready():
	ScoreManager.on_player_score.connect(on_score_updated)
	CharacterManager.on_prompt_generated.connect(changeCurrentPrompt)
	#if name == str(1):
	#	position = Vector2(-218,380)
	#else:
	#	position = Vector2(1039,380)
	
	#if is_multiplayer_authority():
	#	playerText.editable = true
	#	playerText.focus_mode = 3
	#else:
	#	playerText.editable = false
	#	playerText.focus_mode = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ScoreManager.currentRound == 7:
		isJaja = true
	if isJaja == true:
		answer1.disabled = true
		answer2.disabled = true
		answer3.disabled = true

func _on_line_edit_text_submitted(new_text):
	if isJaja == false:
		if(new_text == prompt):
			print("YES!")
			ScoreManager.add_player_msg_to_chat(name.to_int(), new_text)
			ScoreManager.add_player_score(name.to_int(), calculateScore())
		else:
			print("NO!")

func calculateScore() -> int:
	var charTrait1 = CharacterManager.current_character.postive1
	var charTrait2 = CharacterManager.current_character.postive2
	var charTrait3 = CharacterManager.current_character.negative1
	var charTrait4 = CharacterManager.current_character.negative2
	if charTrait1 == promptTrait or charTrait2 == promptTrait:
		print("Rizz")
		return 2
	elif charTrait3 == promptTrait or charTrait4 == promptTrait:
		print("Someone fucked up")
		return -2
	else:
		print("The smash 4 of flirting.")
		return 1

func on_score_updated():
	# Called whenever a player scores
	playerText.text = ""
	# Generate a new prompt

func _on_line_edit_text_changed(new_text):
	
	var idk = ""

	if new_text.length() == prompt.length():
		for i in new_text.length():
			if new_text[i] == prompt[i]:
				idk += "[color=black]" + prompt[i] + "[/color]"
			else:
				idk += "[color=red]" + prompt[i] + "[/color]"
			i+=1
	elif new_text.length() > prompt.length():
		var diff = prompt.length()
		for i in prompt.length():
			if new_text[i] == prompt[i]:
				idk += "[color=black]" + prompt[i] + "[/color]"
			else:
				idk += "[color=red]" + prompt[i] + "[/color]"
			i+=1
		while diff < new_text.length():
				idk += "[color=red]" + new_text[diff] + "[/color]"
				diff += 1
	else:
		if new_text.length() > 0:
			for i in new_text.length():
				if new_text[i] == prompt[i]:
					idk += "[color=black]" + prompt[i] + "[/color]"
				else:
					idk += "[color=red]" + prompt[i] + "[/color]"
				i+=1
			var diff = new_text.length()
			while diff < prompt.length():
				idk += "[color=gray]" + prompt[diff] + "[/color]"
				diff += 1
		else:
			var diff = new_text.length()
			while diff < prompt.length():
				idk += "[color=gray]" + prompt[diff] + "[/color]"
				diff += 1
	
	labelAwesome.text = idk

func changeCurrentPrompt(prompt_number):
	rpc_change_prompt.rpc(prompt_number)

@rpc("any_peer", "call_local", "reliable")
func rpc_change_prompt(prompt_number):
	prompt = "Select an answer"
	playerText.focus_mode = 0
	playerText.text = ""
	currentPrompt = prompt_number
	displayPrompt.text = CharacterManager.current_character.prompts[currentPrompt].promptText
	labelAwesome.text = "[color=gray]" + prompt + "[/color]"
	answer1.text = CharacterManager.current_character.prompts[currentPrompt].answer1.answerText
	answer2.text = CharacterManager.current_character.prompts[currentPrompt].answer2.answerText
	answer3.text = CharacterManager.current_character.prompts[currentPrompt].answer3.answerText

func _on_answer_1_pressed():
	prompt = CharacterManager.current_character.prompts[currentPrompt].answer1.answerText
	labelAwesome.text = "[color=gray]" + prompt + "[/color]"
	promptTrait = CharacterManager.current_character.prompts[currentPrompt].answer1.answerTrait
	playerText.focus_mode = 2

func _on_answer_2_pressed():
	prompt = CharacterManager.current_character.prompts[currentPrompt].answer2.answerText
	labelAwesome.text = "[color=gray]" + prompt + "[/color]"
	promptTrait = CharacterManager.current_character.prompts[currentPrompt].answer2.answerTrait
	playerText.focus_mode = 2

func _on_answer_3_pressed():
	prompt = CharacterManager.current_character.prompts[currentPrompt].answer3.answerText
	labelAwesome.text = "[color=gray]" + prompt + "[/color]"
	promptTrait = CharacterManager.current_character.prompts[currentPrompt].answer3.answerTrait
	playerText.focus_mode = 2
