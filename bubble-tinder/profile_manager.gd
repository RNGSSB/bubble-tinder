extends Control

func _on_select_character(character: Character) -> void:
	print("HAS SELECTED A CHARACTER, EDITING DATA: " + str(multiplayer.get_unique_id()))
	var name_string = "[b]" + character.name + ", " + str(character.age)
	$"Text and Emojis/Name Box/RichTextLabel".text = name_string
	$"Text and Emojis/Descripcion/RichTextLabel".text = character.description
	$"Match Picture Contain/TextureRect".texture = character.profile_picture
