extends CanvasLayer

@onready var fade: ColorRect = $Fade

func _ready() -> void:
	fade.color.a = 0.0

func change_scene(path: String, duration: float = 0.4) -> void:
	# Fade to black
	var tween_out = create_tween()
	tween_out.tween_property(fade, "color:a", 1.0, duration)
	await tween_out.finished

	# Swap scene while screen is black
	get_tree().change_scene_to_file(path)
	await get_tree().process_frame  # let new scene finish loading

	# Fade back in
	var tween_in = create_tween()
	tween_in.tween_property(fade, "color:a", 0.0, duration)
	await tween_in.finished
