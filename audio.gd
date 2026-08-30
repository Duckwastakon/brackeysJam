extends Node2D


func playSound(sound, speed = 1):
	var newSfx: AudioStreamPlayer2D = AudioStreamPlayer2D.new()
	add_child(newSfx)
	newSfx.position = Vector2.ZERO
	newSfx.stream = load(sound)
	newSfx.bus = &"SFX"
	newSfx.play()
	await newSfx.finished
	newSfx.queue_free()
	
