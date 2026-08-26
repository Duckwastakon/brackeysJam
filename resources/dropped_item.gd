extends CharacterBody2D

const decel = 25
var startingScale = 1
var amount = 1
var itemName = "sticks"

func _ready() -> void:
	startingScale = scale.x * randf_range(0.6, 1.2)
	
	await get_tree().create_timer(1.5).timeout
	$Area2D/CollisionShape2D.disabled = false

func setItem(item, amt):
	itemName = item
	amount = amt
	$itemSprite.texture = load(CraftableItems.items[item]["png"])

func _physics_process(delta: float) -> void:
	if(velocity != Vector2.ZERO):
		velocity.x = move_toward(velocity.x, 0, decel)
		velocity.y = move_toward(velocity.y, 0, decel)
		var scl = clamp(startingScale * velocity.length() / 200, 1, 1.6)
		scale = Vector2(scl, scl)
		
		move_and_slide()
