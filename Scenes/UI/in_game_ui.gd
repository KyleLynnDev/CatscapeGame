extends Control

@onready var options_menu: OptionsMenu = $Options_Menu
@onready var options: Button = $VBoxContainer/Options
@onready var world: Node3D = $".."

var options_open := false


func _ready() -> void:
	options.set_process(false)
	
func _on_options_pressed() -> void:
	SoundManager.any_button_pressed()
	if options_open == false:
		options.text = "OPTIONS >"
		options_menu.visible = true
		options_menu.set_process(true)
		options_open = true
	elif options_open == true:
		options.text = "OPTIONS"
		options_menu.visible = false
		options_menu.set_process(false)
		options_open = false
		
