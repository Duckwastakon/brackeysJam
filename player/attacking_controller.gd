extends Node2D

@onready var hitBoxRotator = $hitBoxRotating

var dir = 1
@export var swingWidth = 60
signal swingSignal

var canAttack = true
var tool = "fists"

func _ready() -> void:
	connect("swingSignal", swing)

func swing(equipedItem):
	if(!canAttack): return
	tool = equipedItem
	canAttack = false
	$hitBoxRotating/Area/CollisionShape2D.disabled = false
	$hitBoxRotating/Area/ColorRect.visible = true
	
	var mousePos = get_global_mouse_position()
	hitBoxRotator.look_at(mousePos)
	
	hitBoxRotator.rotation_degrees -= swingWidth / 2 * dir
	
	var rotationTween = create_tween()
	rotationTween.tween_property(hitBoxRotator, "rotation_degrees", 
	hitBoxRotator.rotation_degrees + swingWidth * dir, 0.08)
	rotationTween.play()
	
	await rotationTween.finished
	$hitBoxRotating/Area/CollisionShape2D.disabled = true
	$hitBoxRotating/Area/ColorRect.visible = false
	rotationTween.kill()
	dir *= -1
	canAttack = true

func _on_area_area_entered(area: Area2D) -> void:
	area.damage.emit(tool)
