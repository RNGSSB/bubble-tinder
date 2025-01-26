extends Control

@onready var playerText = $"Typing/Line Edit/MarginContainer/Line Edit"
@onready var labelAwesome = $"Typing/Option 1/MarginContainer/RichTextLabel"
@onready var answer1 = $"Options/Option 1"
@onready var answer2 = $"Options/Option 2"
@onready var answer3 = $"Options/Option 3"
@onready var typingPanel = $Typing
@onready var optionsPanel = $Options
@export var currentPrompt = 0
var prompt = "Select an answer"
var promptTrait = Traits.Traits.FLIRTY
var isJaja = false



func _enter_tree():
	set_multiplayer_authority(name.to_int())

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_input(true)
	ScoreManager.on_player_score.connect(on_score_updated)
	ScoreManager.on_request_jajas.connect(send_jaja_to_manager)
	CharacterManager.on_prompt_generated.connect(changeCurrentPrompt)
	#if name == str(1):
	#	position = Vector2(-218,380)
	#else:
	#	position = Vector2(1039,380)
	
	if is_multiplayer_authority():
		playerText.editable = true
	else:
		playerText.process_mode = Node.PROCESS_MODE_DISABLED
		answer1.process_mode = Node.PROCESS_MODE_DISABLED
		answer2.process_mode = Node.PROCESS_MODE_DISABLED
		answer3.process_mode = Node.PROCESS_MODE_DISABLED
		playerText.focus_mode = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ScoreManager.currentRound == 7:
		if isJaja == false:
			# Enter haha mode
			playerText.focus_mode = 2
			playerText.grab_focus()
			answer_chosen.rpc()
		isJaja = true
	if isJaja == true:
		answer1.get_node("Text Message").disabled = true
		answer2.get_node("Text Message").disabled = true
		answer3.get_node("Text Message").disabled = true
		
func _input(ev):
	if Input.is_key_pressed(KEY_ENTER) and is_multiplayer_authority():
		_on_line_edit_text_submitted()

func _on_line_edit_text_submitted():
	var new_text = playerText.text
	if isJaja == false:
		if(new_text == prompt):
			print("YES!")
			ScoreManager.add_player_msg_to_chat(name.to_int(), new_text)
			ScoreManager.add_player_score(name.to_int(), calculateScore())
		else:
			print("NO!")

func calculateFinalRound():
	pass

func send_jaja_to_manager():
	ScoreManager.set_jaja_value.rpc(multiplayer.get_unique_id(), playerText.text)

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

func _on_line_edit_text_changed():
	var new_text = playerText.text
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
	playerText.text = ""
	rpc_change_prompt.rpc(prompt_number)

@rpc("any_peer", "call_local", "reliable")
func rpc_change_prompt(prompt_number):
	prompt = "Select an answer"
	playerText.focus_mode = 0
	playerText.text = ""
	currentPrompt = prompt_number
	labelAwesome.text = "[color=gray]" + prompt + "[/color]"
	answer1.get_node("MarginContainer/RichTextLabel").text = CharacterManager.current_character.prompts[currentPrompt].answer1.answerText
	answer2.get_node("MarginContainer/RichTextLabel").text = CharacterManager.current_character.prompts[currentPrompt].answer2.answerText
	answer3.get_node("MarginContainer/RichTextLabel").text = CharacterManager.current_character.prompts[currentPrompt].answer3.answerText
	if ScoreManager.currentRound != 7:
		show_options.rpc()

func _on_answer_1_pressed():
	prompt = CharacterManager.current_character.prompts[currentPrompt].answer1.answerText
	labelAwesome.text = "[color=gray]" + prompt + "[/color]"
	promptTrait = CharacterManager.current_character.prompts[currentPrompt].answer1.answerTrait
	playerText.focus_mode = 2
	playerText.grab_focus()
	answer_chosen.rpc()

func _on_answer_2_pressed():
	prompt = CharacterManager.current_character.prompts[currentPrompt].answer2.answerText
	labelAwesome.text = "[color=gray]" + prompt + "[/color]"
	promptTrait = CharacterManager.current_character.prompts[currentPrompt].answer2.answerTrait
	playerText.focus_mode = 2
	playerText.grab_focus()
	answer_chosen.rpc()

func _on_answer_3_pressed():
	prompt = CharacterManager.current_character.prompts[currentPrompt].answer3.answerText
	labelAwesome.text = "[color=gray]" + prompt + "[/color]"
	promptTrait = CharacterManager.current_character.prompts[currentPrompt].answer3.answerTrait
	playerText.focus_mode = 2
	playerText.grab_focus()
	answer_chosen.rpc()

@rpc("any_peer", "call_local", "reliable")
func answer_chosen():
	optionsPanel.visible = false
	typingPanel.visible = true

@rpc("any_peer", "call_local", "reliable")
func show_options():
	optionsPanel.visible = true
	typingPanel.visible = false
