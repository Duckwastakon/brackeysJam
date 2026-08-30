extends Node
@onready var timer = $sacerfice

var player_in_range = false
var inventory = null
var currentPoints = 0
var needPoints = 10

func _process(delta: float) -> void:
	if player_in_range and Input.is_action_just_pressed("e"):
		sacrifice()

func sacrifice() -> void:
	if inventory == null:
		return

	var equipped = inventory.getItem(Global.equippedIndex)
	var item_name = equipped[0]
	var amount = equipped[1]

	if item_name == "":
		return

	var item_data = CraftableItems.items[item_name]
	if not item_data.has("points"):
		return 
	var points_gained = item_data["points"] * amount
	currentPoints += points_gained
	inventory.removeItem(item_name, amount)

	if currentPoints >= needPoints:
		currentPoints = 0
		update_points()
		added()

func update_points() -> void:
	needPoints = needPoints * 1.2

func _on_sacerfice_timeout() -> void:
	timer.start()

func added() -> void:
	if AnimalData.phase == 1:
		timer.start()
	else:
		AnimalData.phase -= 1
		AnimalData.set_monster_speed()
		timer.start()

func _on_enter_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = true
		inventory = body.get_node("inventory")

func _on_enter_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = false
		inventory = null
