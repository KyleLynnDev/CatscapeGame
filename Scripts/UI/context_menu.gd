extends Control

@onready var popup_menu: PopupMenu = $PopupMenu


# Called when the node enters the scene tree for the first time.
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("RightMouse"):
		var mousePos = get_viewport().get_mouse_position()
		popup_menu.position.x = mousePos.x
		popup_menu.position.y = mousePos.y
		popup_menu.popup()
		
