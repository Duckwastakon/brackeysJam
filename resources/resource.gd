extends Area2D

var resourceName
var hp
signal damage

const resource = preload("res://resources/dropped_item.tscn")
@onready var resourceSprite = $resourceSprite

func _ready() -> void:
	connect("damage", shakeObject)
	
	setupResource("tree")

func setupResource(name):
	resourceName = name
	var data = CraftableItems.resourceNodes[name]
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
	
	var DPD = CraftableItems.resourceNodes[resourceName]["hp"] / CraftableItems.resourceNodes[resourceName]["dropTimes"]
	var droppedResources = (dmg - (dmg % DPD)) / DPD
	if hp%DPD<(hp-dmg)%DPD:
		droppedResources += 1
	
	for i in droppedResources:
		hp -= DPD
		if hp > 0:
			generateItem()
		else:
			for x in 5:
				generateItem()
			
			break
	
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
