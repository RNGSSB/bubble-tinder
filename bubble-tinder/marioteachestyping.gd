extends Node2D

@onready var playerText = $LineEdit
@onready var labelAwesome = $Label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_line_edit_text_submitted(new_text):
	print(new_text.length())
	
	var idk = ""
	
	if new_text.length() == labelAwesome.text.length():
		print("Equal lenght!")
		for i in new_text.length():
			if new_text[i] == labelAwesome.text[i]:
				print(" Character " + str(i) + "is correct.")
			else:
				idk += labelAwesome.text[i]
				print(labelAwesome.text[i] + " Wrong, stupid.")
			i+=1
	elif new_text.length() > labelAwesome.text.length():
		print("Input text is bigger than prompt")
		var diff = labelAwesome.text.length() + 1
		for i in labelAwesome.text.length():
			if new_text[i] == labelAwesome.text[i]:
				print(" Character " + str(i) + "is correct.")
			else:
				idk += labelAwesome.text[i]
				print(labelAwesome.text[i] + " Wrong, stupid.")
			i+=1
		while diff < new_text.length():
				print("Esto esta de mas :/ " + new_text[diff])
				diff += 1
	else:
		print("Input text is smaller than prompt")
		if new_text.length() > 0:
			for i in new_text.length():
				if new_text[i] == labelAwesome.text[i]:
					print(" Character " + str(i) + "is correct.")
				else:
					idk += labelAwesome.text[i]
					print(labelAwesome.text[i] + " Wrong, stupid.")
				i+=1
			var diff = new_text.length() + 1
			while diff < labelAwesome.text.length():
				print("Te falto " + labelAwesome.text[diff])
				diff += 1
		else:
			var diff = new_text.length()
			while diff < labelAwesome.text.length():
				print("Te falto " + labelAwesome.text[diff])
				diff += 1
		
	
	
	
	if(new_text == labelAwesome.text):
		print("YES!")
	else:
		print("NO!")
		print(idk)
