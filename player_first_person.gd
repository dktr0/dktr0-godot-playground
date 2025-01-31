extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const ACCEL = 10.0
const DECEL = 15.0

var mouseLookLeftRight = 0;
var mouseLookUpDown = 0;

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$"skeleton/AnimationPlayer".get_animation("Idle").loop_mode = Animation.LOOP_LINEAR;
	$"skeleton/AnimationPlayer".get_animation("Walk").loop_mode = Animation.LOOP_LINEAR;
	$"skeleton/AnimationPlayer".play("Idle");

func _physics_process(delta):
	var stickLook = Input.get_vector("lookleft","lookright","lookup","lookdown")*(-0.1);
	rotate_y(mouseLookLeftRight + stickLook.x);
	$Camera3D.rotate_x(mouseLookUpDown + stickLook.y);
	$Camera3D.rotation.x = clampf($Camera3D.rotation.x, -deg_to_rad(70), deg_to_rad(70))

	if not is_on_floor(): # gravity
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor(): # jumping
		velocity.y = JUMP_VELOCITY

	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var dir = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized();
	if dir:
		velocity.x = move_toward(velocity.x, dir.x*SPEED, abs(dir.x*ACCEL*delta));
		velocity.z = move_toward(velocity.z, dir.z*SPEED, abs(dir.z*ACCEL*delta));
		$"skeleton/AnimationPlayer".play("Walk");
	else:
		var velDir = velocity.normalized();
		velocity.x = move_toward(velocity.x, 0, abs(velDir.x*DECEL*delta));
		velocity.z = move_toward(velocity.z, 0, abs(velDir.z*DECEL*delta));
		$"skeleton/AnimationPlayer".play("Idle");
	move_and_slide()
	
func _input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		mouseLookLeftRight = -event.relative.x * 0.01; # increase/decrease 0.01 to change sensitivity
		if abs(mouseLookLeftRight) < 0.02: # dead zone for mouse motion left/right
			mouseLookLeftRight = 0.0;
		mouseLookUpDown = -event.relative.y * 0.01; # increase/decrease 0.01 to change sensitivity
		if abs(mouseLookUpDown) < 0.02: # dead zone for mouse motion up/down
			mouseLookUpDown = 0.0;

func _on_area_3d_body_entered(body):
	pass # not doing anything here yet...

func _on_area_3d_area_entered(area):
	pass # not doing anything here yet...
