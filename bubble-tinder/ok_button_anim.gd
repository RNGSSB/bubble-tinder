extends Node

@export var onpress_rotation = -0.4
@export var player_has_confirmed = false
@export var player_number = 1
@export var belongs_to_player = false

signal player_confirm_signal
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Check if this belongs to the player.
	_start_tween()

func _check_belongs_to_player(is_player_one):
	if is_player_one:
		if player_number == 1:
			pass
		else:
			get_parent().mouse_filter = Control.MOUSE_FILTER_IGNORE
	else:
		if player_number == 1:
			get_parent().mouse_filter = Control.MOUSE_FILTER_IGNORE
		else:
			pass
func _start_tween():
	var t = create_tween().set_loops()
	t.tween_property(get_parent(), "position:y", -15, 1).set_trans(Tween.TRANS_SINE).as_relative()
	t.tween_property(get_parent(), "position:y", 15, 1).set_trans(Tween.TRANS_SINE).as_relative()

func _on_button_hover_anim():
	var t = create_tween()
	t.tween_property(get_parent(), "scale", Vector2(1.05, 1.05), 0.1).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
func _on_button_unhover_anim():
	if get_parent().disabled == false:
		var t = create_tween()
		t.tween_property(get_parent(), "scale", Vector2(1.0, 1.0), 0.1).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)


func _on_button_press_anim():
	player_ready.rpc()

@rpc("call_local", "reliable", "any_peer")
func player_ready():
	var t = create_tween()
	get_parent().disabled = true
	get_parent().mouse_filter = Control.MOUSE_FILTER_IGNORE
	t.tween_property(get_parent(), "scale", Vector2(1.2, 1.2), 0.1).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	t.set_parallel()
	t.tween_property(get_parent(), "rotation", onpress_rotation, 0.2).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT).as_relative()
	print("I've emitted the signal: " + get_parent().name)
	player_has_confirmed = true
	player_confirm_signal.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta: float) -> void:
	pass
