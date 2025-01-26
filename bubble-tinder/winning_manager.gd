extends Control

@export var winning_texture : Texture2D
@export var losing_texture: Texture2D

@export var player_one_image : TextureRect
@export var player_two_image : TextureRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func set_win_images(win_id):
	if win_id == 1:
		# Player one won
		player_one_image.texture = winning_texture
		player_two_image.texture = losing_texture
	else:
		player_one_image.texture = losing_texture
		player_two_image.texture = winning_texture
		
	player_one_image.self_modulate = Color(1,1,1,0)
	player_two_image.self_modulate = Color(1,1,1,0)
	
	var t_one = create_tween()
	t_one.tween_property(player_one_image, "position:y", -30, 0).as_relative()
	t_one.tween_property(player_one_image, "self_modulate", Color(1,1,1,1), 0.3).set_trans(Tween.TRANS_CUBIC)
	t_one.set_parallel()
	t_one.tween_property(player_one_image, "position:y", 30, 0.6).set_trans(Tween.TRANS_BOUNCE)
	
	var t_two = create_tween()
	t_two.tween_property(player_two_image, "position:y", -30, 0).as_relative()
	t_two.tween_property(player_two_image, "self_modulate", Color(1,1,1,1), 0.3).set_trans(Tween.TRANS_CUBIC)
	t_two.set_parallel()
	t_two.tween_property(player_two_image, "position:y", 30, 0.6).set_trans(Tween.TRANS_BOUNCE)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
