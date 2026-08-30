extends HSlider

func _ready() -> void:
	value = Global.shake_intensity
	_update_label(value)

func _on_value_changed(new_value: float) -> void:
	Global.shake_intensity = new_value
	_update_label(new_value)

func _update_label(v: float) -> void:
	$"../number".text = str(int(v))
