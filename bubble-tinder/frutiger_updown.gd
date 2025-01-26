extends TextureRect

@export var positions = [-10.0, 10.0]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var t = create_tween().set_loops()
	t.tween_property($".", "position:y", positions[0], 3).set_trans(Tween.TRANS_SINE).as_relative()
	t.tween_property($".", "position:y", positions[1], 3).set_trans(Tween.TRANS_SINE).as_relative()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
