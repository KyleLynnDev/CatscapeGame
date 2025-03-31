extends Node

@onready var ui_button_sound: AudioStreamPlayer = $"UI button"
@onready var main_menu: AudioStreamPlayer = $Main_Menu
@onready var sign_creak_sound: AudioStreamPlayer = $SignCreak
@onready var play_chime: AudioStreamPlayer = $PlayChime
@onready var fantastic: AudioStreamPlayer = $fantastic
@onready var overworld: AudioStreamPlayer = $Overworld


func any_button_pressed():
	if !ui_button_sound.is_playing():
		ui_button_sound.play()

func _ready() -> void:
	main_menu.volume_db = -5
	overworld.volume_db = -8

func sign_pressed():
	sign_creak_sound.play()
