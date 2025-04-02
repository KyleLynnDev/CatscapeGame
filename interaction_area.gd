extends Area3D
class_name interactable

@export var interact_type := ""
var can_interact = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node3D) -> void:
	if body is player:
		can_interact = true
		print("PLAYER HAS ENTERED")


func _on_body_exited(body: Node3D) -> void:
	if body is player:
		can_interact = false
		print("PLAYER GO BYE BYE")
