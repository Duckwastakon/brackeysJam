extends CanvasLayer

var inventory = []
var invAmounts = []

var surroundingPlaceables = []

@export var inventorySize = 6
@onready var invSlot = $invSlot
@onready var slotContainer = $container

@onready var craftableButton = $craftable
@onready var craftableContainer = $craftableItems

var crafting = false
signal startCrafting

signal changeHealth
signal changeHunger
signal changeTemperature

signal updatedSlot

func _ready() -> void:
	for i in inventorySize:
		inventory.append("")
		invAmounts.append(0)
	
	drawInventory()
	
	connect("changeHealth", newHealth)
	connect("changeHunger", newHunger)
	connect("changeTemperature", newTemperature)

func newHealth(amount):
	updateBar($health, amount)

func newHunger(amount):
	updateBar($hunger, amount)

func newTemperature(amount):
	updateBar($warmth, amount)

func drawInventory():
	var allSlotSize = 64*inventorySize
	
	for i in inventorySize:
		var newInvSlot = invSlot.duplicate()
		
		slotContainer.add_child(newInvSlot)
		newInvSlot.visible = true
		newInvSlot.position = Vector2(slotContainer.size.x/2 - allSlotSize/2 + 64*i,0)
		newInvSlot.get_child(0).text = str(i+1)
	
	equipItem(0)

func updateSlot(index):
	var slot = slotContainer.get_child(index)
	var slotItem
	if (inventory[index] == ""):
		slotItem = {"stackable": false, "png": "", "scale": 0}
	else:
		slotItem = CraftableItems.items[inventory[index]]
	
	if slotItem["stackable"] == true:
		slot.get_child(0).text = str(invAmounts[index])
	else:
		slot.get_child(0).text = ""
	
	slot.get_child(1).texture = load(slotItem["png"])
	print(slotItem)
	slot.get_child(1).scale = Vector2(slotItem["scale"], slotItem["scale"])
	updatedSlot.emit(index)

func equipItem(ind):
	Global.equippedIndex = ind  # --------------------------------------------------------------------------- Niko added this
	for i in slotContainer.get_child_count():
		if i == ind:
			slotContainer.get_child(i).color = Color.from_rgba8(255, 255, 255, 50)
		else:
			slotContainer.get_child(i).color = Color.from_rgba8(255, 255, 255, 25)
	$equipedItemName.text = inventory[ind]
	return([inventory[ind], invAmounts[ind]])

func getItem(ind):
	return([inventory[ind], invAmounts[ind]])

func canPickup(itemName):
	if crafting: return false
	var itemData = CraftableItems.items[itemName]
	
	if itemData == null: return false
	
	var stackable = itemData["stackable"]
	if(stackable):
		if(inventory.has(itemName)): return true
	if(inventory.has("")): return true
	
	return false

func pickUpItem(itemName, amount = 1):
	var result = canPickup(itemName)
	print(result)
	if(result):
		addItem(itemName, amount)
	
	return result

func dropItem(index):
	if crafting: return [""]
	var item = [inventory[index], invAmounts[index]]
	inventory[index] = ""
	invAmounts[index] = 0
	updateSlot(index)
	setCrafting()
	$equipedItemName.text = ""
	return item

func setCrafting(override = false):
	if crafting and !override: return
	
	for c in craftableContainer.get_children():
		#if c is Button:
		#	c.disconnect("mouse_entered", showData)
		#	c.disconnect("mouse_exited", hideData)
		#	c.disconnect("button_up", craft)
		c.queue_free()
	
	var i = 0
	for craftable in CraftableItems.cratables:
		var possible = true
		for item in CraftableItems.cratables[craftable]["items"]:
			if(inventory.has(item)):
				if(invAmounts[inventory.find(item)] >= CraftableItems.cratables[craftable]["items"][item]):
					pass
				else:
					possible = false
					break
			else:
				possible = false
				break
		if(CraftableItems.cratables[craftable].has("builds")):
			for build in CraftableItems.cratables[craftable]["builds"]:
				if(!surroundingPlaceables.has(build)):
					possible = false
					break
		
		if(possible):
			var newButton: Button = craftableButton.duplicate()
			var currentButtons = i
			i+=1
			var y = (currentButtons - (currentButtons%5))/5
			var x = currentButtons - y*5
			
			craftableContainer.add_child(newButton)
			newButton.position = Vector2(8+64*x, 8+64*y)
			newButton.get_child(0).texture = load(CraftableItems.items[craftable]["png"])
			newButton.get_child(0).scale = Vector2(CraftableItems.items[craftable]["scale"], CraftableItems.items[craftable]["scale"])
			newButton.visible = true
			
			newButton.connect("mouse_entered", showData.bind(craftable, newButton))
			newButton.connect("mouse_exited", hideData.bind(newButton))
			newButton.connect("button_up", craft.bind(craftable, CraftableItems.cratables[craftable]["items"], newButton))

func checkHasSpace(itemName, cost):
	var stackable = CraftableItems.items[itemName]["stackable"]
	if(stackable):
		if(inventory.has(itemName)): return true
	if(inventory.has("")): return true
	for item in cost:
		if(invAmounts[inventory.find(item)] - cost[item] <= 0):
			return true
	
	return false

func craft(itemName, costs, btn: Button):
	if(crafting): return
	if(!checkHasSpace(itemName, costs)): return
	
	crafting = true
	startCrafting.emit()
	var craftingTime = 3
	
	var colorRectInd = ColorRect.new()
	btn.add_child(colorRectInd)
	colorRectInd.position = Vector2(0, btn.size.y)
	colorRectInd.modulate = Color.from_rgba8(114, 44, 43, 100)
	colorRectInd.size = Vector2(btn.size.x, btn.size.y)
	colorRectInd.scale = Vector2(1, 0)
	colorRectInd.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	var timerTween = create_tween()
	timerTween.tween_property(colorRectInd, "scale", Vector2(1, -1), craftingTime)
	timerTween.play()
	await timerTween.finished
	for item in costs:
		removeItem(item, costs[item])
	addItem(itemName, 1)
	await setCrafting(true)
	
	crafting = false
	timerTween.kill()
	if(colorRectInd):
		colorRectInd.queue_free()

func addItem(item, amount):
	var id
	if(inventory.has(item) and CraftableItems.items[item]["stackable"]):
		invAmounts[inventory.find(item)] += amount
		id = inventory.find(item)
	else:
		id = inventory.find("")
		inventory[id] = item
		invAmounts[id] = amount
	
	setCrafting()
	updateSlot(id)

func removeItem(item, amount):
	var id = inventory.find(item)
	invAmounts[id] -= amount
	if invAmounts[id] <= 0:
		inventory[id] = ""
	
	setCrafting()
	updateSlot(id)

var currentDataParent = null
@onready var dataShowcase = $craftingInfo

func showData(itemName, btn):
	currentDataParent = btn
	var data = CraftableItems.cratables[itemName]["items"]
	dataShowcase.visible = true
	for i in dataShowcase.get_child_count():
		if i == 0 or i == 1:
			pass
		else:
			dataShowcase.get_child(i).queue_free()
	
	var amount = CraftableItems.cratables[itemName]["amount"]
	if amount > 1:
		dataShowcase.get_child(1).text = str(amount) + "x " + itemName
	else:
		dataShowcase.get_child(1).text = itemName
	
	dataShowcase.get_child(0).size = Vector2(128, 24*(data.size()+1))
	
	var i = 1
	for resourceName in data:
		var newText = dataShowcase.get_child(1).duplicate()
		newText.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		
		var txt = str(data[resourceName]) + ": " + str(resourceName)
		
		newText.text = txt
		dataShowcase.add_child(newText)
		newText.position = Vector2(0, 24 * i)
		i+=1

func hideData(btn):
	if (currentDataParent == btn):
		dataShowcase.visible = false

func updateBar(bar: Control, amount: float):
	var background: ColorRect = bar.get_child(0)
	var fill: ColorRect = background.get_child(0)
	
	var blinkingIndicator = fill.duplicate()
	blinkingIndicator.color = Color.from_rgba8(0, 0, 0, 50)
	background.add_child(blinkingIndicator)
	
	var newSize: float = clamp(amount / 100, 0, 1)
	
	var newTween = create_tween()
	newTween.tween_property(fill, "scale", Vector2(newSize, 1), 0.3)
	newTween.play()
	await newTween.finished
	newTween.kill()
	blinkingIndicator.queue_free()

func addPlaceable(placeableName):
	surroundingPlaceables.append(placeableName)

func removePlaceable(placeableName):
	surroundingPlaceables.erase(placeableName)
