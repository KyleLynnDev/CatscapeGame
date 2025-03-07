extends Node3D

func _ready() -> void:
	SoundManager.overworld.play()
	Dialogic.start_timeline("IntroductionDialogue")

@onready var player: Node3D = $Player
@onready var npc_sirfrog: CharacterBody3D = $GameWorld/NPC_sirfrog

func _physics_process(delta: float) -> void:
	get_tree().call_group("NPC", "update_target_location", player.global_transform.origin)
