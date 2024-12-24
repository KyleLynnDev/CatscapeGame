extends Sprite3D

@onready var camera_3d = $"../../Pivot/Camera3D"
@onready var target = $"../../../CameraTarget"



@export var animationColumn : int = 0; 
var camera : Camera3D = null; 


func _ready():
	set_camera(camera_3d)

func set_camera(c):
	camera = camera_3d ;
	
func _process(delta):
	if camera == null:
		return
	
	
	
	var playerForwardBasis =  -camera.global_transform.basis.z;
	
	
	var forwardBasis = global_transform.basis.z;
	var leftBasis = global_transform.basis.x;
	
	var leftDotProduct = -leftBasis.dot(playerForwardBasis);
	var forwardDotProduct = -forwardBasis.dot(playerForwardBasis);
	
	#print(leftDotProduct)
	#print(forwardDotProduct)
	
	var row = 0;
	flip_h = false;
	
	#check to see which row you use 
	if forwardDotProduct < -0.85:
		row = 0; # front of sprite 
	elif forwardDotProduct > 0.85:
		row = 4; #back sprite
	else:
		flip_h = leftDotProduct > 0;
		if abs(forwardDotProduct) < 0.3:
			row = 2; #left sprite
		elif forwardDotProduct < 0:
			row = 1; #forward left sprite
		else:
			row = 3;
	
	frame = animationColumn + row * 4; 
	
