extends Camera3D

#export variables

@export var movement_speed : float = 20; 
@export var min_elevation_angle : int = 10; 
@export var max_elevation_angle : int = 80;
@export var rotation_speed : float = 20; 

#flags

@export var allow_rotation : bool = true; 
@export var invertedY : bool = false; 
@export var zoomToCursor : bool = false; 

#params

#movement
var _last_mouse_position : Vector2 = Vector2(); 
var _is_rotating : bool = false;

#zoom
var _zoom_direction = 0;
@export var minZoom : int = 10;
@export var maxZoom : int = 30;
@export var zoomSpeed : float = 10;
@export var zoomSpeedDamp : float = 0.5;

#refs
@onready var cameraTarget = $"../../../CameraTarget"

@onready var pivot = $".."

#click on object
var mouse = Vector2();


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_rotate(delta);
	_zoom(delta);
	#cameraTarget.position = global_position;
	#cameraTarget.position.y = 0;
	

func _unhandled_input(event):
	#test if we are rotating
	if (event.is_action_pressed("CameraRotate")):
		_is_rotating = true;
		_last_mouse_position = get_viewport().get_mouse_position();
	if (event.is_action_released("CameraRotate")):
		_is_rotating = false;
	#test if zooming
	if (event.is_action_pressed("CameraZoomIn")):
		_zoom_direction = -1; 
	if (event.is_action_pressed("CameraZoomOut")):
		_zoom_direction = 1; 
	


	


func _rotate(delta : float) -> void:
	if not _is_rotating or not allow_rotation:
		return; 
	#calculate mouse movement
	var displacement = _get_mouse_displacement();
	#use horizontal displacement to rotate
	_roate_left_right(delta, displacement.x);
	#use vertical displacement to elevate
	_elevate(delta,-displacement.y);

	
	
func _get_mouse_displacement() -> Vector2:
	var current_mouse_position = get_viewport().get_mouse_position();
	var displacement = current_mouse_position - _last_mouse_position;
	_last_mouse_position = current_mouse_position; 
	return displacement; 
	
func _roate_left_right(delta : float, val : float) -> void:
	pivot.rotation_degrees.y -= val * delta * rotation_speed;
	

func _elevate(delta: float, val: float) -> void:
	#calculate new elevation
	var newElevation = pivot.rotation_degrees.x + val * delta * rotation_speed;
	#clamp new elevation
	newElevation = clamp(newElevation, -max_elevation_angle, -min_elevation_angle)
	#set new elevation based on clamped value
	pivot.rotation_degrees.x = newElevation; 
	
	
	#print(pivot.rotation_degrees.x)
	
	
func _zoom(delta : float) -> void:
	#calculate the new zoom
	var newZoom = clamp(position.z + zoomSpeed * delta * _zoom_direction, minZoom,maxZoom);
	#clamp between min and max zoom
	position.z = newZoom; 
	#stop scrolling
	_zoom_direction *= zoomSpeedDamp;
	if abs(_zoom_direction) <= 0.0001:
		_zoom_direction = 0;
	
	
