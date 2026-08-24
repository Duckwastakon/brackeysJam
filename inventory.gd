extends CanvasLayer

var inventory = []
var invAmounts = []

@export var inventorySize = 6
@onready var invSlot = $invSlot
@onready var slotContainer = $container

func _ready() -> void:
	for i in inventorySize:
		inventory.append("")
	
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

func pickUpItem(itemName):
	var stackable = true
	if(stackable):
		if(inventory.has(itemName)):
			invAmounts[inventory.find(itemName)] += 1
			return true
		else:
			for i in inventory.size():
				if inventory[i] == "":
					inventory[i] = itemName
					invAmounts[i] = 1
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
	var item = inventory[ind]
	inventory[ind] = ""
	invAmounts[ind] = 0
	return item
