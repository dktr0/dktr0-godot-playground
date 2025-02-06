extends StaticBody3D

func _on_input_event(camera, event, event_position, normal, shape_idx):
	print("here")
	if event.is_action_pressed("left_click"):
		print("clicked");

func _on_mouse_entered():
	print("mouse entered");
	
func _on_mouse_exited():
	print("mouse exited");
