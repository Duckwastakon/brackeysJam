extends CharacterBody2D

var movingState = 0
@export var maxSpeed = [500, 1000]
@export var accelerations = [150, 250]
@export var deceleration = 100

@onready var playerArt = $playerArt
@onready var inventory = $inventory
@onready var attackingController = $AttackingController

const itemPrefab = preload("res://resources/dropped_item.tscn")

var equipedSlot = 0
var equipedItem = ""

var health = 100
var hunger = 100
var temperature = 100

var healthChange
var hungerChange
var temperatureChange

var cooldown = false

func _ready() -> void:
	healthChange = inventory.changeHealth
	hungerChange = inventory.changeHunger
	temperatureChange = inventory.changeTemperature
	inventory.connect("updatedSlot", itemChanged)

func itemChanged(index):
	if index == equipedSlot:
		equipItem(index)

func _physics_process(delta: float) -> void:
	var movementDirection = Vector2(Input.get_axis("left", "right"), 
	Input.get_axis("up", "down")).normalized()
	
	if(movementDirection != Vector2.ZERO):
		velocity += movementDirection * accelerations[movingState]
		
		if(movementDirection.x == 0):
			velocity.x = move_toward(velocity.x, 0, deceleration)
		if(movementDirection.y == 0):
			velocity.y = move_toward(velocity.y, 0, deceleration)
		lockSpeed()
	else:
		velocity.x = move_toward(velocity.x, 0, deceleration)
		velocity.y = move_toward(velocity.y, 0, deceleration)
	
	Global.wobble(playerArt, velocity)
	move_and_slide()

func lockSpeed():
	if(abs(velocity.x) > maxSpeed[movingState]):
		if(abs(velocity.x) > 1.5*maxSpeed[movingState]):
			velocity.x = move_toward(velocity.x, 0, deceleration * 3)
		else:
			velocity.x = velocity.x / abs(velocity.x) * maxSpeed[movingState]
	if(abs(velocity.y) > maxSpeed[movingState]):
		if(abs(velocity.y) > 1.5*maxSpeed[movingState]):
			velocity.y = move_toward(velocity.y, 0, deceleration * 3)
		else:
			velocity.y = velocity.y / abs(velocity.y) * maxSpeed[movingState]

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("shift"):
		movingState = 1
	if Input.is_action_just_released("shift") and movingState == 1:
		movingState = 0
	
	if Input.is_action_just_pressed("click"):
		mouseClicked()
	
	if Input.is_action_just_pressed("1"): equipItem(0)
	if Input.is_action_just_pressed("2"): equipItem(1)
	if Input.is_action_just_pressed("3"): equipItem(2)
	if Input.is_action_just_pressed("4"): equipItem(3)
	if Input.is_action_just_pressed("5"): equipItem(4)
	if Input.is_action_just_pressed("6"): equipItem(5)
	
	if Input.is_action_just_pressed("q"):
		var droppedItem = inventory.dropItem(equipedSlot)
		if droppedItem[0] == "": return
		equipedItem = ""
		var itemClone = itemPrefab.instantiate()
		print(droppedItem)
		itemClone.setItem(droppedItem[0], droppedItem[1])
		itemClone.global_position = global_position
		itemClone.rotation_degrees = randi_range(0, 360)
		itemClone.velocity = 500 * randf_range(1, 1.5) * global_position.direction_to(get_global_mouse_position())
		get_parent().add_child(itemClone)

func _on_item_pickup_area_entered(area: Area2D) -> void:
	if(inventory.pickUpItem(area.get_parent().itemName, area.get_parent().amount)):
		area.get_parent().queue_free()

func takeDamage(amount):
	health -= amount
	healthChange.emit(health)
	
	if health <= 0:
		die()

func looseHunger(amount):
	if movingState == 1:
		amount *= 2
	hunger -= amount
	if hunger <= 0:
		hunger = 0
		takeDamage(10)
	hungerChange.emit(hunger)

func eat(foodItem):
	var data = CraftableItems.items[foodItem]
	hunger += data["foodScore"]
	health += data["heal"]
	healthChange.emit(health)
	hungerChange.emit(hunger)
	inventory.removeItem(foodItem, 1)
	await inventory.delay(3)
	cooldown = false

func changeTemperature(amount):
	temperature += amount
	temperatureChange.emit(temperature)

func die():
	pass

@onready var placingController = $placingController

func equipItem(index):
	equipedSlot = index
	equipedItem = inventory.equipItem(index)[0]
	
	if(equipedItem == ""): 
		stopPlacing()
		return
	
	if CraftableItems.items[equipedItem]["type"] == "placeable":
		startPlacing()
	else:
		stopPlacing()

func startPlacing():
	placingController.visible = true
	placingController.get_child(0).texture = load(CraftableItems.items[equipedItem]["png"])
	placingController.get_child(0).scale = Vector2(CraftableItems.items[equipedItem]["scale"], CraftableItems.items[equipedItem]["scale"])
	

func stopPlacing():
	placingController.visible = false

func mouseClicked():
	if cooldown: return
	cooldown = true
	if(equipedItem == ""):
		attackingController.swingSignal.emit("fists")
		await inventory.delay(2.5)
		cooldown = false
		return
	var equipedItemType = CraftableItems.items[equipedItem]["type"]
	if equipedItemType == "item":
		attackingController.swingSignal.emit("fists")
		await inventory.delay(2.5)
	elif equipedItemType == "food":
		eat(equipedItem)
		return
	elif equipedItemType == "tool":
		attackingController.swingSignal.emit(equipedItem)
		await inventory.delay(CraftableItems.items[equipedItem]["cooldown"])
	elif equipedItemType == "placeable":
		if(placingController.placeBuild(equipedItem)):
			inventory.dropItem(equipedSlot)
	cooldown = false

func _on_hunger_timer_timeout() -> void:
	looseHunger(randi_range(3, 5))
	$hungerTimer.wait_time = randf_range(0.8, 1.5)
	$hungerTimer.start()

func _on_warmth_timer_timeout() -> void:
	$warmthTimer.wait_time = randf_range(2.7, 5.4)
	$warmthTimer.start()
	changeTemperature(calculateWarmthChange())

var warmthObjects = []

func calculateWarmthChange():
	var amount = 0
	var multiplier = 1
	if(Global.dayTime):
		amount -= randi_range(2, 5)
		multiplier += 0.2
	else:
		amount -= randi_range(8, 20)
		multiplier += 0.25
	
	for warmthObject in warmthObjects:
		amount += CraftableItems.placeables[warmthObject]["warmth"] * randf_range(0.5, 1.5)
	
	return amount * multiplier

func _on_placeable_enter_area_entered(area: Area2D) -> void:
	if(CraftableItems.placeables[area.type].has("warmth")):
		warmthObjects.append(area.type)
	inventory.addPlaceable(area.type)
	
	print(warmthObjects)

func _on_placeable_enter_area_exited(area: Area2D) -> void:
	if(CraftableItems.placeables[area.type].has("warmth")):
		warmthObjects.erase(area.type)
	inventory.removePlaceable(area.type)
	
	print(warmthObjects)
