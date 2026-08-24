extends Node2D

@onready var hitBoxRotator = $hitBoxRotating

var dir = 1
@export var swingWidth = 60

var canAttack = true

func swing():
	canAttack = false
	$hitBoxRotating/Area/ColorRect.visible = true
	
	var mousePos = get_global_mouse_position()
	hitBoxRotator.look_at(mousePos)
	
	hitBoxRotator.rotation_degrees -= swingWidth / 2 * dir
	
	var rotationTween = create_tween()
	rotationTween.tween_property(hitBoxRotator, "rotation_degrees", 
	hitBoxRotator.rotation_degrees + swingWidth * dir, 0.08)
	rotationTween.play()
	
	await rotationTween.finished
	$hitBoxRotating/Area/ColorRect.visible = false
	rotationTween.kill()
	dir *= -1
	canAttack = true


func _process(delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and canAttack:
		swing()

func _on_area_area_entered(area: Area2D) -> void:
	area.shake.emit()
