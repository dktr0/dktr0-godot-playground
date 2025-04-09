extends StaticBody3D

signal clicked()

func _on_input_event(camera, event, event_position, normal, shape_idx):
	if event.is_action_pressed("left_click"):
		clicked.emit();
