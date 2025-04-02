extends StaticBody3D
class_name FullTree

@onready var interaction_area: Area3D = $InteractionArea
@onready var full_tree: MeshInstance3D = $FullTree
@onready var stump: MeshInstance3D = $Stump

func _ready() -> void:
	stump.visible = false
	full_tree.visible = true

func _physics_process(_delta: float) -> void:
	pass
