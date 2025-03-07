class_name OptionsMenu
extends Control

@onready var exit_button: Button = $Exit_Button

@onready var settings_right: TextureRect = $Settings_Margin/Settings_Right
@onready var settings_mid: TextureRect = $Settings_Margin/Settings_Mid
@onready var settings_left: TextureRect = $Settings_Margin/Settings_Left

signal exit_options_menu

func _ready() -> void:
	#exit_button.button_down.connect(_on_exit_button_pressed)
	_on_game_settings_pressed()
	set_process(false)


func _on_exit_button_pressed() -> void:
	SoundManager.any_button_pressed()
	exit_options_menu.emit()
	set_process(false)


func _on_game_settings_pressed() -> void:
	$Settings_Game.visible = true
	$Settings_Video.visible = false
	$Settings_Audio.visible = false
	SoundManager.any_button_pressed()
	settings_mid.visible = false
	settings_right.visible = false
	settings_left.visible = true

func _on_video_settings_pressed() -> void:
	$Settings_Game.visible = true
	$Settings_Video.visible = true
	$Settings_Audio.visible = false
	SoundManager.any_button_pressed()
	settings_mid.visible = true
	settings_right.visible = false
	settings_left.visible = false


func _on_audio_settings_pressed() -> void:
	$Settings_Game.visible = true
	$Settings_Video.visible = false
	$Settings_Audio.visible = true
	SoundManager.any_button_pressed()
	settings_mid.visible = false
	settings_right.visible = true
	settings_left.visible = false


func _on_fullscreen_box_toggled(toggled_on: bool) -> void:
	SoundManager.any_button_pressed()
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_resolution_button_item_selected(index: int) -> void:
	if DisplayServer.WINDOW_MODE_MAXIMIZED:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	if index == 0:
		DisplayServer.window_set_size(Vector2i(1920, 1080))
		get_window().move_to_center()
	elif index == 1:
		DisplayServer.window_set_size(Vector2i(1600, 900))
		get_window().move_to_center()
	elif index == 2:
		DisplayServer.window_set_size(Vector2i(1280, 720))
		get_window().move_to_center()
	elif index == 3:
		DisplayServer.window_set_size(Vector2i(854, 480))
		get_window().move_to_center()
	elif index == 4:
		DisplayServer.window_set_size(Vector2i(640, 360))
		get_window().move_to_center()


func _on_music_volume_value_changed(value: float) -> void:
	pass # Replace with function body.
