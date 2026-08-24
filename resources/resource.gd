extends Area2D

var resourceId = 0
var hp = 5
signal shake

const resourse = preload("res://resources/dropped_item.tscn")

func _ready() -> void:
	connect("shake", shakeObject)

func dropResource():
	var newResource: CharacterBody2D = resourse.instantiate()
	newResource.global_position = global_position
	get_parent().call_deferred("add_child", newResource)
	
	newResource.velocity = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized() * 100 * randf_range(1.1, 1.4)

var shakeAmount = 0

func shakeObject():
	hp -= 1
	if(hp <= 0):
		for i in 5:
			dropResource()
		queue_free()
		return
	else:
		dropResource()
	
	if shakeAmount <= 0:
		shakeAmount = 8
		while(shakeAmount > 0):
			shakeAmount -= 1
			var newTween = create_tween()
			newTween.tween_property($ColorRect, "position",
			Vector2(-48 + randi_range(-4, 4), -48 + randi_range(-4, 4)), 0.04)
			
			newTween.play()
			await newTween.finished
			newTween.kill()
		$ColorRect.position = Vector2(-48, -48)
	else:
		shakeAmount = 8
