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

func betterTools():
	if $equipedItemName2.modulate.a == 0:
		print($equipedItemName2.modulate.a)
		$equipedItemName2.modulate.a = 255
		while($equipedItemName2.modulate.a != 0):
			$equipedItemName2.modulate.a = lerpf($equipedItemName2.modulate.a, 0, 0.5)
			await get_tree().create_timer(0.1).timeout
	else:
		$equipedItemName2.modulate.a = 255
