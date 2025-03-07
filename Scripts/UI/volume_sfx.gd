extends HSlider

@export var audio_bus_name := "SFX"

@onready var _bus := AudioServer.get_bus_index(audio_bus_name)
@onready var sfx_perc: Label = $"../../VBoxContainer2/SFXPerc"


func _ready() -> void:
	value = .5
	#sfx_perc.text = str(value * 100) + "%"
	value = db_to_linear(AudioServer.get_bus_volume_db(_bus))

func _on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(_bus, linear_to_db(value))
	#sfx_perc.text = str(value * 100) + "%"

func _on_mouse_exited() -> void:
	release_focus()


func _on_mute_box_toggled(toggled_on: bool) -> void:
	SoundManager.any_button_pressed()
	AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX"), toggled_on)
