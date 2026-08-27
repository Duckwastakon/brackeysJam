extends Node
@onready var timer = $sacerfice

var player_in_range = false
var inventory = null  # will be set once the player enters range

func _process(delta: float) -> void:
	if player_in_range and Input.is_action_just_pressed("sacrifice"):
		sacrifice()

func sacrifice() -> void:
	if inventory == null:
		return
	
	var equipped = inventory.getItem(Global.equippedIndex)
	var item_name = equipped[0]
	var amount = equipped[1]

	if item_name == "":
		return

	inventory.removeItem(item_name, amount)
	added()

func _on_sacerfice_timeout() -> void:
	if AnimalData.phase == 5:
		timer.start()
	else:
		AnimalData.phase += 1
		timer.start()

func added() -> void:
	if AnimalData.phase == 1:
		timer.start()
	else:
		AnimalData.phase -= 1
		timer.start()

func _on_enter_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = true
		inventory = body.get_node("Inventory")

func _on_enter_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = false
		inventory = null
