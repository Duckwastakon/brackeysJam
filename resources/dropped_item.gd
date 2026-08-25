extends CharacterBody2D

const decel = 25
var startingScale = 1
var amount = 1
var itemName = "sticks"

func _ready() -> void:
	startingScale = $ColorRect.scale.x
	
	await get_tree().create_timer(1.5).timeout
	$Area2D/CollisionShape2D.disabled = false

func setItem(item, amt):
	itemName = item
	amount = amt
	print(item)
	print(CraftableItems.items[item])
	print(CraftableItems.items[item]["png"])
	$itemSprite.texture = load(CraftableItems.items[item]["png"])

func _physics_process(delta: float) -> void:
	if(velocity != Vector2.ZERO):
		velocity.x = move_toward(velocity.x, 0, decel)
		velocity.y = move_toward(velocity.y, 0, decel)
		var scl = clamp(startingScale * velocity.length() / 200, 1, 1.6)
		$ColorRect.scale = Vector2(scl, scl)
		
		move_and_slide()
