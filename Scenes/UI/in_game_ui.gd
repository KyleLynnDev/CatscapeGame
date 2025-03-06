extends CanvasLayer

@onready var options_menu: OptionsMenu = $MouseBlock/Options_Menu
@onready var options: Button = $MenuButtons/Options
@onready var mouse_block: Control = $MouseBlock


var options_open := false


func _ready() -> void:	
	mouse_block.visible = false
	options_menu.visible = false

func _on_options_pressed() -> void:
	SoundManager.any_button_pressed()
	if options_open == false:
		options.text = "OPTIONS >"
		options_menu.visible = true
		mouse_block.visible = true
		options_menu.set_process(true)
		options_open = true
	elif options_open == true:
		options.text = "OPTIONS"
		options_menu.visible = false
		mouse_block.visible = false
		options_menu.set_process(false)
		options_open = false
		
