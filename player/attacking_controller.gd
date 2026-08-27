extends Node2D

@onready var hitBoxRotator = $hitBoxRotating

var dir = 1
@export var swingWidth = 60
signal swingSignal

var canAttack = true
var tool = "fists"

func _ready() -> void:
	connect("swingSignal", swing)

func _process(delta: float) -> void:
	$rotator2.look_at(get_global_mouse_position())

func swing(equipedItem):
	if(!canAttack): return
	tool = equipedItem
	canAttack = false
	if dir == 1:
		$hitBoxRotating/toolImage.flip_h = true
		$hitBoxRotating/toolImage.rotation_degrees = 45
	else:
		$hitBoxRotating/toolImage.flip_h = false
		$hitBoxRotating/toolImage.rotation_degrees = 135
	
	$rotator2/Area/CollisionShape2D.disabled = false
	
	print(equipedItem)
	$hitBoxRotating/toolImage.texture = load(CraftableItems.items[equipedItem]["png"])
	$hitBoxRotating/toolImage.visible = true
	
	var mousePos = get_global_mouse_position()
	hitBoxRotator.look_at(mousePos)
	
	hitBoxRotator.rotation_degrees -= swingWidth / 2 * dir
	
	var rotationTween = create_tween()
	rotationTween.tween_property(hitBoxRotator, "rotation_degrees", 
	hitBoxRotator.rotation_degrees + swingWidth * dir, 0.08)
	rotationTween.play()
	
	await rotationTween.finished
	$rotator2/Area/CollisionShape2D.disabled = true
	$hitBoxRotating/toolImage.visible = false
	rotationTween.kill()
	dir *= -1
	canAttack = true

func _on_area_area_entered(area: Area2D) -> void:
	area.damage.emit(tool)
