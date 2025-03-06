extends Node

@onready var ui_button_sound: AudioStreamPlayer = $"UI button"
@onready var main_menu: AudioStreamPlayer = $Main_Menu
@onready var sign_creak_sound: AudioStreamPlayer = $SignCreak
@onready var fade: AnimationPlayer = $fade
@onready var play_chime: AudioStreamPlayer = $PlayChime
@onready var fantastic: AudioStreamPlayer = $fantastic


func any_button_pressed():
	if !ui_button_sound.is_playing():
		ui_button_sound.play()

func _ready() -> void:
	fade.animation_finished.connect(fade_out)
	main_menu.volume_db = -5
	
func sign_pressed():
	sign_creak_sound.play()

func fade_out():
	fade.play("out")
	
func fade_in():
	fade.play("in")
