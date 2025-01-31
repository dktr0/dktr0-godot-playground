extends CharacterBody3D

func launch(launcher : Node3D, launchSpeed : float, safeDistance : float):
	var q = launcher.quaternion;
	set_quaternion(q); # rotation of rocket matches rotation of launcher
	set_velocity(q*Vector3.FORWARD*launchSpeed); # velocity also determined by that rotation
	# set initial position to safeDistance away in direction of launcher's rotation
	set_global_position(launcher.global_position + (q*Vector3.FORWARD*safeDistance));
	
func _physics_process(delta):
	# if not is_on_floor(): # uncomment this block to make rocket affected by gravity
	#	velocity += get_gravity() * delta;
	move_and_slide()

func _on_area_3d_area_entered(area):
	collidedWithAreaOrBody(area);

func _on_area_3d_body_entered(body):
	collidedWithAreaOrBody(body);
	
func collidedWithAreaOrBody(areaOrBody):	
	if(!areaOrBody.is_in_group("Player") && !areaOrBody.is_in_group("Rocket")):
		print("rocket deleting self because collided with something");
		queue_free();
