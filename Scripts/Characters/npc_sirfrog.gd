extends CharacterBody3D


@onready var agent: NavigationAgent3D = $NavigationAgent3D
var SPEED := 1


func interacted():
	print("this object has been clicked")
	
	await get_tree().create_timer(0.2).timeout
	#uncomment to delete object: self.queue_free()
