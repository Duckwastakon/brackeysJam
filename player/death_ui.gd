extends CanvasLayer



func activate(newText):
	$Control/Label2.text = newText
	
	var newTween = create_tween()
	newTween.tween_property($Control, "modulate", Color.from_rgba8(255, 255, 255, 255), 2)
	newTween.play()

func _on_button_pressed() -> void:
	#await get_tree().create_timer(5.0).timeout
	Transition.change_scene("res://start.tscn")
