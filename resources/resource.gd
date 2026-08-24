extends Area2D

var resourceId = 0
signal shake

func _ready() -> void:
	connect("shake", shakeObject)

var shakeAmount = 0

func shakeObject():
	if shakeAmount <= 0:
		shakeAmount = 20
		while(shakeAmount > 0):
			shakeAmount -= 1
			var newTween = create_tween()
			newTween.tween_property($ColorRect, "position", 
			Vector2(randi_range(-4, 4), randi_range(-4, 4)), 0.04)
			
			newTween.play()
			await newTween.finished
			newTween.kill()
		$ColorRect.position = Vector2(0, 0)
	else:
		shakeAmount = 20
