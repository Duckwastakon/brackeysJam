extends CanvasLayer

var inventory = []
var invAmounts = []

@export var inventorySize = 6
@onready var invSlot = $invSlot
@onready var slotContainer = $container

@onready var craftableButton = $craftable
@onready var craftableContainer = $craftableItems

func _ready() -> void:
	for i in inventorySize:
		inventory.append("")
		invAmounts.append(0)
	
	drawInventory()

func drawInventory():
	var allSlotSize = 64*inventorySize
	
	for i in inventorySize:
		var newInvSlot = invSlot.duplicate()
		
		slotContainer.add_child(newInvSlot)
		newInvSlot.visible = true
		newInvSlot.position = Vector2(slotContainer.size.x/2 - allSlotSize/2 + 64*i,
		slotContainer.size.y/2)
		newInvSlot.get_child(0).text = str(i+1)

func getItem(ind):
	return([inventory[ind], invAmounts[ind]])

func pickUpItem(itemName, amount = 1):
	var success = attemptPickUp(itemName, amount)
	if(success):
		setCrafting()
	
	return success

func attemptPickUp(itemName, amount = 1):
	var stackable = true
	if(stackable):
		if(inventory.has(itemName)):
			invAmounts[inventory.find(itemName)] += amount
			return true
		else:
			for i in inventory.size():
				if inventory[i] == "":
					inventory[i] = itemName
					invAmounts[i] += amount
					return true
	else:
		for i in inventory.size():
			if inventory[i] == "":
				inventory[i] = itemName
				invAmounts[i] = 1
				return true
	
	return false

func pickableUp(itemName):
	var stackable = true
	if(stackable):
		if(inventory.has(itemName)):
			return true
		else:
			for i in inventory.size():
				if inventory[i] == "":
					return true
	else:
		for i in inventory.size():
			if inventory[i] == "":
				return true
	
	return false

func dropItem(ind):
	var item = [inventory[ind], invAmounts[ind]]
	inventory[ind] = ""
	invAmounts[ind] = 0
	return item

func setCrafting():
	for c in craftableContainer.get_children():
		if c is Button:
			c.disconnect("button_up", craft)
		c.queue_free()
	var i = 0
	for craftable in CraftableItems.cratables:
		var possible = true
		for item in CraftableItems.cratables[craftable]:
			if(inventory.has(item)):
				if(invAmounts[inventory.find(item)] >= CraftableItems.cratables[craftable][item]):
					pass
				else:
					possible = false
					break
			else:
				possible = false
				break
		
		if(possible):
			var newButton: Button = craftableButton.duplicate()
			var currentButtons = i
			i+=1
			var y = (currentButtons - (currentButtons%5))/5
			print(craftable)
			print(y)
			var x = currentButtons - y*5
			print(x)
			
			craftableContainer.add_child(newButton)
			newButton.position = Vector2(8+64*x, 8+84*y)
			newButton.text = str(craftable)
			newButton.visible = true
			
			newButton.connect("button_up", craft.bind(craftable, CraftableItems.cratables[craftable], newButton))

var crafting = false

func craft(itemName, costs, btn: Button):
	if(crafting): return
	
	crafting = true
	var craftingTime = 3
	
	var colorRectInd = ColorRect.new()
	btn.add_child(colorRectInd)
	colorRectInd.position = Vector2(0, btn.size.y)
	colorRectInd.modulate = Color.from_rgba8(48, 48, 48, 100)
	colorRectInd.size = Vector2(btn.size.x, btn.size.y)
	colorRectInd.scale = Vector2(1, 0)
	
	var timerTween = create_tween()
	timerTween.tween_property(colorRectInd, "scale", Vector2(1, -1), craftingTime)
	timerTween.play()
	await timerTween.finished
	timerTween.kill()
	if(colorRectInd):
		colorRectInd.queue_free()
	
	crafting = false

func removeItems(items):
	pass
