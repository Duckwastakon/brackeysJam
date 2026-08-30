extends Area2D

var maxHealth
var hp
signal damage

var healthShowcaseTween: Tween

const resource = preload("res://resources/dropped_item.tscn")
@onready var resourceSprite = $resourceSprite

func _ready() -> void:
	connect("damage", shakeObject)
	
	setupResource()
	
	healthShowcaseTween = create_tween()
	healthShowcaseTween.tween_property(indicatorBackground, "modulate", Color.from_rgba8(255, 255, 255, 0), 2)

func setupResource():
	maxHealth = 5
	hp = 5
	scale *= randf_range(0.8, 1.2)

func dropResource(itemName, amount):
	var newResource: CharacterBody2D = resource.instantiate()
	newResource.global_position = global_position
	
	newResource.setItem(itemName, amount)
	get_parent().call_deferred("add_child", newResource)
	
	newResource.velocity = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized() * 500 * randf_range(1.1, 1.4)

var shakeAmount = 0

func shakeObject(tool):
	var dmg = CraftableItems.items[tool]["dmg"]
	if CraftableItems.items[tool]["tier"] < 3:
		dmg = 0
	else:
		dmg = 1
	
	hp -= dmg
	
	if hp<=0:
		generateItem()
		queue_free()
	
	healthShowcase()
	
	if shakeAmount <= 0:
		shakeAmount = 8
		while(shakeAmount > 0):
			shakeAmount -= 1
			var newTween = create_tween()
			newTween.tween_property(resourceSprite, "position",
			Vector2(randi_range(-4, 4), randi_range(-4, 4)), 0.04)
			
			newTween.play()
			await newTween.finished
			newTween.kill()
		resourceSprite.position = Vector2(0, 0)
	else:
		shakeAmount = 8

func generateItem():
	dropResource("gun", 1)
	return

@onready var indicatorBackground = $background
@onready var indicatorFill = $background/fill

func healthShowcase():
	healthShowcaseTween.kill()
	healthShowcaseTween = create_tween()
	healthShowcaseTween.tween_property(indicatorBackground, "modulate", Color.from_rgba8(255, 255, 255, 0), 2)
	indicatorBackground.modulate = Color.from_rgba8(255, 255, 255, 255)
	
	var newScale: float = float(hp) / float(maxHealth)
	
	indicatorFill.scale = Vector2(newScale, 1)
	healthShowcaseTween.play()
