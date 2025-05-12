extends CharacterBody3D

#onready

@onready var body: Node3D = $"Body Root"
@onready var navigationAgent : NavigationAgent3D = $NavigationAgent3D;
@onready var point = $"../Floating Pointer"
@onready var locked_timer: Timer = $"../LockedTimer"
@onready var footstep_rock: AudioStreamPlayer = $"../footstep_rock"
@onready var footstep_grass: AudioStreamPlayer = $"../footstep_grass"
@onready var floortyperay: RayCast3D = $"Body Root/Stubert Model Test/floortyperay"





var speed : float  = 5.0; 
var gravity : float = 9.8;
var targetPosition : Vector3 ; 
var currentlyNavigating : bool;
@onready var player: Node3D = $".."
@onready var movement_animation: AnimationPlayer = $"Body Root/Stubert Model Test/MovementAnimation"
var is_locked := false



# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if currentlyNavigating:
		play_step_sounds()
		#if !footstep_grass.playing:
			#footstep_grass.play()
	if !currentlyNavigating:
		pass#footstep_grass.stop()

	if !movement_animation.is_playing():
		movement_animation.speed_scale = 1.0
		is_locked = false
	
	if Input.is_action_just_pressed("Interact"):
		if movement_animation.current_animation != ("StubertMove/get_item"):
			movement_animation.speed_scale = 2.0
			movement_animation.play("StubertMove/get_item")
			is_locked = true
	
	
	if(not currentlyNavigating) and !is_locked:
		if movement_animation.current_animation != ("StubertMove/idle"):
			movement_animation.play("StubertMove/idle")
		point.visible = false; 
		return
	
	if (currentlyNavigating) and !is_locked:
		if movement_animation.current_animation != ("StubertMove/run"):
			movement_animation.play("StubertMove/run")
			
	
	moveToPoint(delta, speed );
	currentlyNavigating = not navigationAgent.is_navigation_finished()
	
	
func moveToPoint(delta, speed):
	
	#body will face in direction of current target
	var _targetPosition = navigationAgent.target_position; 
	var direction = global_position.direction_to(_targetPosition);
	faceDirection(_targetPosition, delta);
	#move agent based on input target
	pathfindNavAgent()

func _input(event):
	# when LM is clicked raycast from current position to mouse pos direction
	# and the length is rayLength 
	if Input.is_action_just_pressed("LeftMouse") and !is_locked:
		var camera = get_tree().get_nodes_in_group("camera")[0]; 
		var mousePos = get_viewport().get_mouse_position();
		var rayLength = 70; 
		var from = camera.project_ray_origin(mousePos); 
		var to = from + camera.project_ray_normal(mousePos) * rayLength; 
		var space = get_world_3d().direct_space_state;
		
		var rayQuery = PhysicsRayQueryParameters3D.new();
		rayQuery.from = from;
		rayQuery.to = to;
		rayQuery.collide_with_areas = true; 
		
		var result = space.intersect_ray(rayQuery);
		#print(result); 
		
		#var result = space_state.intersect_ray(ray_origin, ray_target, [], collision_mask)
		if result:
			print("Hit Position: ", result.position)
			print("Hit Object: ", result.collider)
		
	
		if(result.has("position")):
			#navigationAgent.target_position = Vector3(floor(result.position.x),result.position.y,floor(result.position.z));
			targetPosition = result.position;
			
			if result.collider.has_method("interacted"):
				result.collider.interacted(); 	
			else: 
				currentlyNavigating = true;
				point.position = targetPosition;
				point.visible = true; 
			

				
func faceDirection(target_position, delta):
	var direction = Vector3.ZERO
	body.rotation.y = atan2(velocity.x, velocity.z)
	#var direction = (target_position - global_position).normalized()  # Get direction vector
	var current_quat = body.transform.basis.get_rotation_quaternion()  # Get current rotation
	var target_quat = Quaternion(Vector3.UP, atan2(direction.x, direction.z))  # Desired rotation
	body.transform.basis = Basis(current_quat.slerp(target_quat, delta * 5.0))  # Smooth rotation
func pathfindNavAgent():	
	
	#var currentMap = navigationAgent.get_navigation_map(); 
	#var _navmesh_pos = NavigationServer3D.map_get_closest_point(currentMap, targetPosition);
	#navigationAgent.target_position = _navmesh_pos; 
	#print(targetPosition)
	
	navigationAgent.target_position = targetPosition; 
	
	var next_location = navigationAgent.get_next_path_position();
	
	#print("final:", navigationAgent.get_final_position());
	#print("actual:", _navmesh_pos); 
	
	var current_location = transform.origin; 
	var new_velocity = (next_location-current_location).normalized() * speed 
	velocity = velocity.move_toward(new_velocity, 0.25);

	if !is_locked:
		move_and_slide(); 
	
func play_step_sounds():
	if floortyperay.is_colliding():
		var collider = floortyperay.get_collider()
		if collider.is_in_group("grass"):
			if !footstep_grass.playing:
				footstep_grass.play()
		if collider.is_in_group("rock"):
			footstep_rock.play()
