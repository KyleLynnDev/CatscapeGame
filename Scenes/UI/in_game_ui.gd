extends CanvasLayer

@onready var options_menu: OptionsMenu = $MouseBlock/Options_Menu
@onready var options: Button = $MenuButtons/Options
@onready var mouse_block: Control = $MouseBlock
@onready var time_label: Label = $BottomBar/TimeLabel
@onready var in_game_ui: CanvasLayer = $"."
@onready var exit_confirmation: Control = $ExitConfirmation


var options_open := false


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("escape"):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _ready() -> void:	
	exit_confirmation.set_process(false)
	exit_confirmation.visible = false
	set_process(true)
	mouse_block.visible = false
	options_menu.visible = false

func _process(delta):
	update_time()

func update_time():
	var current_time = Time.get_time_dict_from_system()
	time_label.text = str("%02d:%02d:%02d" % [current_time.hour, current_time.minute, current_time.second])

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
	


func _on_tomainmenu_pressed() -> void:
	exit_confirmation.visible = false
	SoundManager.play_chime.play()
	in_game_ui.set_process(false)
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	SoundManager.overworld.stop()
	get_tree().change_scene_to_file("res://Scenes/UI/main_menu.tscn")


func _on_exit_button_pressed() -> void:
	SoundManager.any_button_pressed()
	exit_confirmation.set_process(true)
	exit_confirmation.visible = true


func _on_close_exit_pressed() -> void:
	SoundManager.any_button_pressed()
	exit_confirmation.set_process(false)
	exit_confirmation.visible = false


func _on_todesktop_pressed() -> void:
	SoundManager.any_button_pressed()
	get_tree().quit()
