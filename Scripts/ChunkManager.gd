extends Node


const CHUNK_SIZE = 64;
const RENDER_RADIUS = 2; 

var loaded_chunks = {}; 

var chunk_map = {
	Vector2i(0, 0): "res://Scenes/WorldChunks/chunk_0_0.tscn",
	Vector2i(0, 1): "res://Scenes/WorldChunks/chunk_0_1.tscn",
	Vector2i(0, 2): "res://Scenes/WorldChunks/chunk_0_2.tscn",
	
	Vector2i(1, 0): "res://Scenes/WorldChunks/chunk_1_0.tscn",
	Vector2i(1, 1): "res://Scenes/WorldChunks/chunk_1_1.tscn",
	Vector2i(1, 2): "res://Scenes/WorldChunks/chunk_1_2.tscn",
	
	Vector2i(2, 0): "res://Scenes/WorldChunks/chunk_2_0.tscn",
	Vector2i(2, 1): "res://Scenes/WorldChunks/chunk_2_1.tscn",
	Vector2i(2, 2): "res://Scenes/WorldChunks/chunk_2_2.tscn"
}

@onready var player = get_node("../Player")   # Adjust path as needed
var last_loaded_chunks = [];


func _process(delta):
	if player:
		update_chunks(player.global_transform.origin);

func get_chunks_to_load(player_position):
	var center_x = int(player_position.x / CHUNK_SIZE)
	var center_z = int(player_position.z / CHUNK_SIZE)
	var chunks_to_load = []
	for x in range(center_x - RENDER_RADIUS, center_x + RENDER_RADIUS + 1):
		for z in range(center_z - RENDER_RADIUS, center_z + RENDER_RADIUS + 1):
			chunks_to_load.append(Vector2i(x, z))
	return chunks_to_load
	
	
func update_chunks(player_position):
	var chunks_to_load = get_chunks_to_load(player_position)
		# Compare with last loaded chunks to avoid unnecessary operations
	if chunks_to_load == last_loaded_chunks:
		return # No changes, skip updating

	# Unload chunks no longer in range
	for chunk_key in loaded_chunks.keys():
		if chunk_key not in chunks_to_load:
			unload_chunk(chunk_key)

	# Load new chunks
	for chunk_pos in chunks_to_load:
		if not loaded_chunks.has(chunk_pos):
			load_chunk(chunk_pos)

	# Update the record of last loaded chunks
	last_loaded_chunks = chunks_to_load


func load_chunk(chunk_pos):
	var chunk_scene_path = chunk_map.get(chunk_pos, null)
	if chunk_scene_path:
		var chunk_scene = load(chunk_scene_path)  # Dynamically load the scene
		if chunk_scene:
			var chunk = chunk_scene.instance()
			chunk.position = Vector3(chunk_pos.x * CHUNK_SIZE, 0, chunk_pos.y * CHUNK_SIZE)
			add_child(chunk)
			loaded_chunks[chunk_pos] = chunk
		else:
			pass
			#print_error("Failed to load chunk scene at path: %s" % chunk_scene_path)
			
	
func unload_chunk(chunk_pos):
	if loaded_chunks.has(chunk_pos):
		loaded_chunks[chunk_pos].queue_free()
		loaded_chunks.erase(chunk_pos)
		
 
