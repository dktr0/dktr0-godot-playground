extends CharacterBody3D

const SPEED = 2.0
const ACCEL = 4.0
const DECEL = 6.0

@onready var target = $"/root/Game/Player";

func _physics_process(delta: float) -> void:

	if not is_on_floor(): # gravity
		velocity += get_gravity() * delta;

	# calculate distance to target
	var dist = global_position.distance_to(target.global_position);
	if dist < 10.0: # if distance is less than a certain threshold...
		# ...accelerate in that direction... 
		var dir = (target.global_position - global_position).normalized();
		velocity.x = move_toward(velocity.x,dir.x*SPEED,abs(dir.x*ACCEL*delta));
		velocity.z = move_toward(velocity.z,dir.z*SPEED,abs(dir.z*ACCEL*delta));
		# ...and rotate to face that direction
		look_at(target.global_position);
	else:
		# ...otherwise, slow down in the direction we are already going
		var dir = velocity.normalized();
		velocity.x = move_toward(velocity.x,0,dir.x*DECEL*delta);
		velocity.z = move_toward(velocity.z,0,dir.z*DECEL*delta);
		
	move_and_slide()
