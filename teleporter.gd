extends Area3D

@export var teleportTo: Vector3 = Vector3(0,0,0);

func _on_body_entered(body):
	if(body.is_in_group("Player")):
		body.teleport(teleportTo);
