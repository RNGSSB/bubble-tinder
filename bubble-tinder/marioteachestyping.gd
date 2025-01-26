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



func _enter_tree():
	set_multiplayer_authority(name.to_int())

# Called when the node enters the scene tree for the first time.
func _ready():
	displayPrompt.text = currentCharacter.def.prompts[currentPrompt].promptText
	labelAwesome.text = "[color=gray]" + prompt + "[/color]"
	answer1.text = currentCharacter.def.prompts[currentPrompt].answer1.answerText
	answer2.text = currentCharacter.def.prompts[currentPrompt].answer2.answerText
	answer3.text = currentCharacter.def.prompts[currentPrompt].answer3.answerText
	playerText.focus_mode = 0
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
	pass

func _on_line_edit_text_submitted(new_text):
	if(new_text == prompt):
		print("YES!")
		ScoreManager.add_player_score(name.to_int(), 1)
		changeCurrentPrompt()
	else:
		print("NO!")

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

func changeCurrentPrompt():
	var rng = RandomNumberGenerator.new()
	var arraySize = currentCharacter.def.prompts.size()
	var my_random_number = rng.randi_range(0, arraySize) - 1
	print(my_random_number)
	prompt = "Select an answer"
	playerText.focus_mode = 0
	playerText.text = ""
	currentPrompt = my_random_number
	displayPrompt.text = currentCharacter.def.prompts[currentPrompt].promptText
	labelAwesome.text = "[color=gray]" + prompt + "[/color]"
	answer1.text = currentCharacter.def.prompts[currentPrompt].answer1.answerText
	answer2.text = currentCharacter.def.prompts[currentPrompt].answer2.answerText
	answer3.text = currentCharacter.def.prompts[currentPrompt].answer3.answerText

func _on_answer_1_pressed():
	prompt = currentCharacter.def.prompts[currentPrompt].answer1.answerText
	labelAwesome.text = "[color=gray]" + prompt + "[/color]"
	playerText.focus_mode = 2

func _on_answer_2_pressed():
	prompt = currentCharacter.def.prompts[currentPrompt].answer2.answerText
	labelAwesome.text = "[color=gray]" + prompt + "[/color]"
	playerText.focus_mode = 2

func _on_answer_3_pressed():
	prompt = currentCharacter.def.prompts[currentPrompt].answer3.answerText
	labelAwesome.text = "[color=gray]" + prompt + "[/color]"
	playerText.focus_mode = 2
