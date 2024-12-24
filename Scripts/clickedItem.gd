extends CharacterBody3D

var mouse = Vector2();

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate_object_local(Vector3(0,1,0),0.05); 




func interacted():
	print("this object has been clicked")
	
	await get_tree().create_timer(0.2).timeout
	#uncomment to delete object:
	self.queue_free();
