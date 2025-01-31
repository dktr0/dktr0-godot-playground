extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var mouseLookX = 0;
var mouseLookY = 0;

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	var stickLook = Input.get_vector("lookleft","lookright","lookup","lookdown")*(-0.1);
	rotate_y(mouseLookY + stickLook.x);
	$Camera3D.rotate_x(mouseLookX + stickLook.y);
	$Camera3D.rotation.x = clampf($Camera3D.rotation.x, -deg_to_rad(70), deg_to_rad(70))

	if not is_on_floor(): # gravity
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor(): # jumping
		velocity.y = JUMP_VELOCITY

	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
func _input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		mouseLookY = -event.relative.x * 0.01;
		if abs(mouseLookY) < 0.02:
			mouseLookY = 0.0;
		mouseLookX = -event.relative.y * 0.01;
		if abs(mouseLookX) < 0.02:
			mouseLookX = 0.0;
