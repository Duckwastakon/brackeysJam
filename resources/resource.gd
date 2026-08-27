extends Area2D

var resourceName
var maxHealth
var hp
signal damage

var healthShowcaseTween: Tween

var resourceChances = {
	"tree": 60,
	"rock": 0,
}

const resource = preload("res://resources/dropped_item.tscn")
@onready var resourceSprite = $resourceSprite

func _ready() -> void:
	connect("damage", shakeObject)
	
	var randNum = randi_range(1, 100)
	for obj in resourceChances:
		if resourceChances[obj] < randNum:
			setupResource(obj)
			break
	
	healthShowcaseTween = create_tween()
	healthShowcaseTween.tween_property(indicatorBackground, "modulate", Color.from_rgba8(255, 255, 255, 0), 2)

func setupResource(name):
	resourceName = name
	var data = CraftableItems.resourceNodes[name]
	maxHealth = data["hp"]
	hp = data["hp"]
	resourceSprite.texture = load(data["png"])
	resourceSprite.scale *= randf_range(0.8, 1.2)

func dropResource(itemName, amount):
	var newResource: CharacterBody2D = resource.instantiate()
	newResource.global_position = global_position
	
	newResource.setItem(itemName, amount)
	get_parent().call_deferred("add_child", newResource)
	
	newResource.velocity = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized() * 500 * randf_range(1.1, 1.4)

var shakeAmount = 0

func shakeObject(tool):
	var dmg = CraftableItems.items[tool]["dmg"]
	var toolType = CraftableItems.items[tool]["toolType"]
	if CraftableItems.resourceNodes[resourceName]["toolMult"] == toolType:
		dmg *= CraftableItems.items[tool]["dmgMultiplier"]
	if CraftableItems.items[tool]["tier"] < CraftableItems.resourceNodes[resourceName]["damageTier"]:
		dmg = 0
	
	var DPD = CraftableItems.resourceNodes[resourceName]["hp"] / CraftableItems.resourceNodes[resourceName]["dropTimes"]
	var droppedResources = (dmg - (dmg % DPD)) / DPD
	
	for i in droppedResources:
		hp -= DPD
		if hp > 0:
			generateItem()
		else:
			for x in 5:
				generateItem()
			
			queue_free()
			break
	
	hp -= dmg-droppedResources*DPD
	if(hp > 0 and hp%DPD == 0 and dmg > 0):
		generateItem()
	elif(hp <= 0):
		for x in 5:
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
	var data = CraftableItems.resourceNodes[resourceName]
	var possibleItems = data["drops"]
	
	if(data["multiDrop"]):
		for item in possibleItems:
			var itemChance = possibleItems[item]["chance"]
			if itemChance >= randi_range(1, 100):
				var itemAmt = randi_range(possibleItems[item]["minAmount"], possibleItems[item]["maxAmount"])
				dropResource(item, itemAmt)
	else:
		var randNum = randi_range(1, 100)
		for item in possibleItems:
			var itemChance = possibleItems[item]["chance"]
			if itemChance >= randNum:
				var itemAmt = randi_range(possibleItems[item]["minAmount"], possibleItems[item]["maxAmount"])
				dropResource(item, itemAmt)
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
