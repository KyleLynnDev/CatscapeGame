extends Control


@onready var animation_player: AnimationPlayer = $MainUI/TitleLogo/AnimationPlayer as AnimationPlayer
@onready var play_button: Button = $MainUI/VBoxContainer/Play
@onready var options_button: Button = $MainUI/VBoxContainer/Options
@onready var credits_button: Button = $MainUI/VBoxContainer/Credits
@onready var exit_button: Button = $MainUI/ExitButton
@onready var options_menu: OptionsMenu = $Options_Menu as OptionsMenu
@onready var main_ui: Control = $MainUI as Control
@onready var resolution_button: OptionButton = $Settings_Video/VBoxContainer/ResolutionButton




func _ready() -> void:
	options_menu.exit_options_menu.connect(on_exit_options_menu)
	DisplayServer.window_set_size(Vector2i(1280, 720))
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	get_window().move_to_center()
	SoundManager.main_menu.play()

func _on_title_logo_pressed() -> void:
	if !animation_player.is_playing():
		animation_player.play("sign_swing")
		SoundManager.sign_creak_sound.play()

func _on_play_pressed() -> void:
	SoundManager.play_chime.play()
	SoundManager.fade_out()
	main_ui.set_process(false)
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	SoundManager.main_menu.stop()
	get_tree().change_scene_to_file("res://Scenes/main_world.tscn")

func _on_credits_pressed() -> void:
	SoundManager.any_button_pressed()

func _on_options_pressed() -> void:
	SoundManager.any_button_pressed()
	main_ui.visible = false
	options_menu.set_process(true)
	options_menu.visible = true

func _on_exit_button_pressed() -> void:
	SoundManager.any_button_pressed()
	get_tree().quit()
	

func on_exit_options_menu() -> void:
	SoundManager.any_button_pressed()
	main_ui.visible = true
	options_menu.visible = false
