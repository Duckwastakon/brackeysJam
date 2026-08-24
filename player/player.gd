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
			velocity.x = move_toward(velocity.x, 0, deceleration)
		else:
			velocity.x = velocity.x / abs(velocity.x) * maxSpeed[movingState]
	if(abs(velocity.y) > maxSpeed[movingState]):
		if(abs(velocity.y) > 1.5*maxSpeed[movingState]):
			velocity.y = move_toward(velocity.y, 0, deceleration)
		else:
			velocity.y = velocity.y / abs(velocity.y) * maxSpeed[movingState]

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("shift"):
		movingState = 1
	if Input.is_action_just_released("shift") and movingState == 1:
		movingState = 0
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		attackingController.swingSignal.emit(equipedItem)
	
	if Input.is_action_just_pressed("1"):
		equipedSlot = 0
		equipedItem = inventory.getItem(equipedSlot)[0]
	if Input.is_action_just_pressed("2"):
		equipedSlot = 1
		equipedItem = inventory.getItem(equipedSlot)[0]
	if Input.is_action_just_pressed("3"):
		equipedSlot = 2
		equipedItem = inventory.getItem(equipedSlot)[0]
	if Input.is_action_just_pressed("4"):
		equipedSlot = 3
		equipedItem = inventory.getItem(equipedSlot)[0]
	if Input.is_action_just_pressed("5"):
		equipedSlot = 4
		equipedItem = inventory.getItem(equipedSlot)[0]
	if Input.is_action_just_pressed("6"):
		equipedSlot = 5
		equipedItem = inventory.getItem(equipedSlot)[0]
	
	if Input.is_action_just_pressed("q"):
		var droppedItem = inventory.dropItem(equipedSlot)
		if droppedItem[0] == "": return
		equipedItem = ""
		var itemClone = itemPrefab.instantiate()
		print(droppedItem)
		itemClone.itemName = droppedItem[0]
		itemClone.amount = droppedItem[1]
		itemClone.global_position = global_position
		itemClone.rotation_degrees = randi_range(0, 360)
		itemClone.velocity = 500 * randf_range(1, 1.5) * global_position.direction_to(get_global_mouse_position())
		get_parent().add_child(itemClone)

func _on_item_pickup_area_entered(area: Area2D) -> void:
	if(inventory.pickUpItem(area.get_parent().itemName, area.get_parent().amount)):
		area.get_parent().queue_free()
