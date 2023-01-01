class_name Player extends KinematicBody;

#
# Constants
#
const ACCEL := 0.25;
const MOVE_SPEED := 15.0;

const GRAVITY_ACCEL := 25;
const JUMP_FORCE := 7.5;

#
# Node/Scene References
#
onready var head := $Head;
onready var interact_cast := $Head/Interaction;


#
# Variables
#
var velocity := Vector3();
var gravity_vec := Vector3();


########################
### Normal Functions ###
########################

## Ready
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);

## Input
func _input(event: InputEvent) -> void:
	## Toggle mouse capture/visible
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);
	
	## Look around with the mouse
	if event is InputEventMouseMotion:
		mouselook(event);


## Physics
func _physics_process(delta: float) -> void:
	movement(delta);
	if interact_cast.is_colliding():
		interactions();
	else:
		head.update_crosshair();

########################
### Player Functions ###
########################

## Movement
func movement(delta) -> void:
	#
	# Horizontal Movement
	#
	
	## Get horizontal movement based on player input
	## transform.basis.xform converts the vector from world space to player space
	var h_dir := transform.basis.xform(Vector3(
		Input.get_action_strength("player_right") - Input.get_action_strength("player_left"),
		0.0,
		Input.get_action_strength("player_backward") - Input.get_action_strength("player_forward") 
	).normalized() * MOVE_SPEED);
	
	## Acceleration/Deceleration
	if velocity != h_dir:
		velocity = lerp(velocity, h_dir, ACCEL);
	
	
	#
	# Vertical Movement
	#
	if !is_on_floor():
		## Apply Gravity
		gravity_vec += Vector3.DOWN * GRAVITY_ACCEL * delta;
		gravity_vec.y = clamp(gravity_vec.y, -GRAVITY_ACCEL, GRAVITY_ACCEL);
	else:
		if Input.is_action_just_pressed("player_jump"):
			## Jump
			gravity_vec = Vector3.UP * JUMP_FORCE;
		else:
			## Point gravity at the current floor so walking up slopes doesn't suck
			gravity_vec = -get_floor_normal()
	
	## Apply gravity/jumping
	velocity += gravity_vec;
	
	
	## Actually move the player
	move_and_slide(velocity, Vector3.UP);

## Mouse Look
func mouselook(event: InputEvent) -> void:
	var mouse_sens: float = PlayerConf.get_setting("controls", "mouse_sens");
		
	## Look left/right
	rotate_y(deg2rad(
		-event.relative.x * mouse_sens
	));
	
	## Look up/down
	head.rotate_x(-deg2rad(event.relative.y) * mouse_sens);
	
	## Clamp up/down rotation
	head.rotation.x = clamp(head.rotation.x, deg2rad(-90), deg2rad(90));

## Interactions
func interactions() -> void:
	var collider = interact_cast.get_collider();
	
	## if the collider is an interactable
	if collider is Interactable:
		## If the collider can be interacted with
		if collider.is_enabled():
			head.update_crosshair(collider.get_crosshair());
			## If the player tries to interact
			if Input.is_action_just_pressed("player_interact"):
				collider.call_deferred("interact");
				return;
			elif Input.is_action_just_pressed("player_plant") && collider is Plot:
				collider.call_deferred("plant_crop");
				return;
			return;
	
	## Set the crosshair to default if none of the above apply
	head.update_crosshair();
