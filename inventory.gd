extends CanvasLayer

var inventory = []
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
