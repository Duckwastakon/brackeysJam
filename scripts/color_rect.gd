extends ColorRect

@export var speed := 0.1

func _process(delta: float) -> void:
	material.set_shader_parameter("custom_time", material.get_shader_parameter("custom_time") + delta * speed)
