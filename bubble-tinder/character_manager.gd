extends Node

@export var character_list : Array[Resource]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _generate_characters() -> int:
	var character_random = character_list.pick_random()
	return character_list.find(character_random, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
