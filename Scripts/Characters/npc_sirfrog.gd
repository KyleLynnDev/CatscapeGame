extends CharacterBody3D
@onready var froganimation: AnimationPlayer = $SirFrog/froganimation


@onready var agent: NavigationAgent3D = $NavigationAgent3D
var SPEED := 1


func interacted():
	print("this object has been clicked")
	
	await get_tree().create_timer(0.2).timeout
	#uncomment to delete object: self.queue_free()
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("Emote"):
		if froganimation.current_animation != ("EmoteStubert/fantastic"):
			froganimation.play("EmoteStubert/fantastic")
