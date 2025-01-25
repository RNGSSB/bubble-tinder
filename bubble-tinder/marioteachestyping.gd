extends Node2D

@onready var playerText = $LineEdit
@onready var labelAwesome = $EpicLabel
@export var prompt = "Sonic Adventure 2 Battle"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_line_edit_text_submitted(new_text):
	if(new_text == prompt):
		print("YES!")
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
