extends Node

@export var onpress_rotation = -0.4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_start_tween()

func _start_tween():
	var t = create_tween().set_loops()
	t.tween_property(get_parent(), "position:y", -15, 1).set_trans(Tween.TRANS_SINE).as_relative()
	t.tween_property(get_parent(), "position:y", 15, 1).set_trans(Tween.TRANS_SINE).as_relative()

func _on_button_hover_anim():
	var t = create_tween()
	t.tween_property(get_parent(), "scale", Vector2(1.05, 1.05), 0.1).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
func _on_button_unhover_anim():
	var t = create_tween()
	if get_parent().disabled == false:
		t.tween_property(get_parent(), "scale", Vector2(1.0, 1.0), 0.1).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)


func _on_button_press_anim():
	var t = create_tween()
	get_parent().disabled = true
	get_parent().mouse_filter = Control.MOUSE_FILTER_IGNORE
	t.tween_property(get_parent(), "scale", Vector2(1.2, 1.2), 0.1).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	t.set_parallel()
	t.tween_property(get_parent(), "rotation", onpress_rotation, 0.2).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT).as_relative()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
