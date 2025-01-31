extends Control

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("fullscreen"):
		var m = get_window().mode;
		if m == Window.MODE_WINDOWED:
			get_window().mode = Window.MODE_FULLSCREEN;
		else:
			get_window().mode = Window.MODE_WINDOWED;

func _on_start_game_button_pressed():
	print("you pressed the button");
	get_tree().change_scene_to_file("res://game.tscn");
