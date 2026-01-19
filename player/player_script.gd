extends CharacterBody3D
class_name PossumPlayer3D

@export var jump_force = 10.0
@export var gravity = 10
@export var walking_speed = 5
@export var sensitivity = 0.01
@export var rotation_speed:float = 20

func _ready():
	# beginning of game, capture mouse
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	var move_input = Input.get_vector("left","right","back","forward")
	
	# rotate movement input towards where the camera is looking
	var move_dir = move_input.rotated(%spring.rotation.y)
	
	# apply walking speed
	move_dir *= walking_speed
	
	var new_velocity = Vector3()
	var velocity_y = velocity.y
	# apply movement
	new_velocity.x = -move_dir.x
	new_velocity.z = move_dir.y

	velocity = lerp(velocity, new_velocity, 4.0 * delta)

	# apply gravity
	velocity.y = velocity_y - gravity * delta
 
	
	var vel2d = Vector2(velocity.x, velocity.z)
	$AnimationTree.set("parameters/IdleWalkBlend/blend_position", vel2d.length() / walking_speed)
	
	
	# rotate possum model towards where we're walking
	var velocity_xz = Vector3(velocity.x, 0, velocity.z)
	if(velocity_xz.length() > 0.1):
		var target = transform.origin - velocity_xz
		var weight = 1 - exp(-rotation_speed * delta)
		look_at_smoothly(%Possum,target, weight)
			

	move_and_slide()

func _input(event: InputEvent):
	if(event.is_action_pressed("jump") and is_on_floor()):
		print("jump!")
		velocity.y = jump_force
	if(event is InputEventMouseMotion):
		# apply mouse rotation
		%spring.rotation.x += event.relative.y * sensitivity
		%spring.rotation.y -= event.relative.x * sensitivity
		# limit vertical rotation 
		%spring.rotation_degrees.x = clampf(%spring.rotation_degrees.x,-45,45)
	
	if(event.is_action_pressed("exit")):
		get_tree().quit()



func look_at_smoothly(node: Node3D, target: Vector3, weight: float = 0.5, up: Vector3 = Vector3(0, 1, 0), use_model_front: bool = false) -> void:
	var current_transform = node.global_transform
	var target_transform = current_transform.looking_at(target, up)
	if use_model_front:
		# Rotate 180 degrees around the up axis
		target_transform.basis = target_transform.basis.rotated(up.normalized(), PI)
	# interpolated between current and target transforms
	node.global_transform = current_transform.interpolate_with(target_transform, weight)
