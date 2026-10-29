extends HSlider

func _ready() -> void:
	var bus_idx = AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_volume_db(bus_idx, linear_to_db(Global.sfxAudio / 10))
	value = db_to_linear(AudioServer.get_bus_volume_db(bus_idx)) * 10
	_update_label(value)

func _on_value_changed(new_value: float) -> void:
	var bus_idx = AudioServer.get_bus_index("SFX")
	Global.sfxAudio = new_value
	AudioServer.set_bus_volume_db(bus_idx, linear_to_db(new_value / 10))
	_update_label(new_value)

func _update_label(v: float) -> void:
	$"../number".text = str(int(v))
