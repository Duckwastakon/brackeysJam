extends Node2D


@export var labelSetn: LabelSettings

func makeText(txt):
	var newLabel = Label.new()
	newLabel.text = txt
	get_parent().get_parent().add_child(newLabel)
	newLabel.size = Vector2(64, 64)
	newLabel.position = global_position + Vector2(-32, -32) + Vector2(randi_range(-16, 16), randi_range(-16, 16))
	newLabel.label_settings = labelSetn
	newLabel.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	newLabel.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	newLabel.z_index = 999
	
	var moveTween = create_tween()
	var transparencyTween = create_tween()
	
	moveTween.tween_property(newLabel, "position", global_position + Vector2(randi_range(-64, 64), randi_range(-48, 48)), 2)
	transparencyTween.tween_property(newLabel, "modulate", Color.from_rgba8(255, 255, 255, 0), 2)
	
	moveTween.play()
	transparencyTween.play()
	
	await moveTween.finished
	
	newLabel.queue_free()
