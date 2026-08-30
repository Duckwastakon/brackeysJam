extends Node2D


func playSound(sound):
	var newSfx: AudioStreamPlayer2D = AudioStreamPlayer2D.new()
	newSfx.stream = load(sound)
	newSfx.bus = &"SFX"
	newSfx.play()
	await newSfx.finished
	newSfx.queue_free()
	
