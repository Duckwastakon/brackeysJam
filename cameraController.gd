extends Node

var shakeTime = 0

func shakeCamera(intensity: float):
	intensity *= Global.shake_intensity
	var currentCam: Camera2D = get_viewport().get_camera_2d()
	
	if shakeTime <= 0:
		shakeTime = randi_range(7, 9)
		while shakeTime > 0:
			var offsetx = randi_range(-32, 32) * intensity
			var offsety = randi_range(-32, 32) * intensity
			
			var newTween = create_tween()
			newTween.tween_property(currentCam, "offset", Vector2(offsetx, offsety), 0.04)
			newTween.play()
			await newTween.finished
			shakeTime -= 1
		
		var newTween = create_tween()
		newTween.tween_property(currentCam, "offset", Vector2(0, 0),  0.04)
		newTween.play()
	
	else:
		shakeTime = randi_range(7, 9)

var shaking = false

func infShake(intensity):
	intensity *= Global.shake_intensity
	var currentCam: Camera2D = get_viewport().get_camera_2d()
	shaking = true
	
	while shaking:
		var offsetx = randi_range(-32, 32) * intensity
		var offsety = randi_range(-32, 32) * intensity
		
		var newTween = create_tween()
		newTween.tween_property(currentCam, "offset", Vector2(offsetx, offsety), 0.04)
		newTween.play()
		await newTween.finished
	
	var newTween = create_tween()
	newTween.tween_property(currentCam, "offset", Vector2(0, 0),  0.04)
	newTween.play()

func stopShaking():
	shaking = false

func zoomInCamera(amount):
	var currentCam: Camera2D = get_viewport().get_camera_2d()
	
	var newTween = create_tween()
	newTween.tween_property(currentCam, "zoom", Vector2(0.9 + amount, 0.9 + amount), 0.4)
	newTween.play()

func unZoomCamera():
	var currentCam: Camera2D = get_viewport().get_camera_2d()
	
	var newTween = create_tween()
	newTween.tween_property(currentCam, "zoom", Vector2(0.9, 0.9), 0.4)
	newTween.play()
