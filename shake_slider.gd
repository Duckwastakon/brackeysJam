extends HSlider

func _ready() -> void:
	value = Global.shake_intensity * 100
	_update_label(value)

func _on_value_changed(new_value: float) -> void:
	Global.shake_intensity = new_value / 100.0
	_update_label(new_value)

func _update_label(v: float) -> void:
	$"../number".text = str(int(v))
