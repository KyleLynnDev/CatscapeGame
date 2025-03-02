extends StaticBody3D

#assign the player's chunk detector
@export var chunkDetector : Area3D; 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if chunkDetector:
		chunkDetector.body_entered.connect(_on_chunk_detector_body_entered);
		chunkDetector.body_exited.connect(_on_chunk_detector_body_exited); 
	else:
		push_error("chunk detector area 3d not assigned");



func _on_chunk_detector_body_entered(body: StaticBody3D) -> void:
	if body == self:
		print("Chunk entered detection area")  # Debugging
		get_parent().set_visible(true)  # Enable rendering
		get_parent().set_process(true)  # Enable processing if needed
	
	
func _on_chunk_detector_body_exited(body: StaticBody3D) -> void:
	if body == self:
		print("Chunk exited detection area")  # Debugging
		get_parent().set_visible(false)  # Disable rendering
		get_parent().set_process(false)  # Disable processing if needed
