extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 8

An
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta;

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY;

	var input_dir = Input.get_vector("left", "right", "left", "right");
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized();
	# handling 4 different possibilities:
	# these can easily be tweaked to the requirements of specific games
	if direction: # if player is pressing a direction control...
		if is_on_floor(): # AND they are on the floor...
			velocity.x = move_toward(velocity.x,SPEED,input_dir.x*SPEED*delta);
			# velocity.x = input_dir.x * SPEED; # 1. they speed up in that direction.
		else: # BUT if they are not on the floor...
			velocity.x = move_toward(velocity.x,SPEED,input_dir.x*SPEED*delta*0.1) # 2. they speed up more slowly in that direction
	else: # if player is not pressing a direction control...
		if is_on_floor(): # AND they are on the floor...
			velocity.x = move_toward(velocity.x,0,SPEED*delta); # 3. they slow gradually to a halt
		else: # BUT if they are not on the floor...
			velocity.x = move_toward(velocity.x,0,SPEED*delta*0.1); # 4. they slow down much more gradually
	move_and_slide()
	
	if Input.is_action_just_pressed("fire"):
		var r = rocketScene.instantiate();
		add_child(r);
		r.launch(self,1.0);
		
func _on_area_3d_area_entered(area):
	if(area.is_in_group("Trampoline")):
		velocity.y = 10;

func teleport(teleportTo: Vector3):
	global_position = teleportTo;		
