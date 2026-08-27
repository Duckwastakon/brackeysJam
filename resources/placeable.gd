extends Area2D


@onready var rangeCollision: CollisionShape2D = $range
@onready var spriteNode: Sprite2D = $placeableImage

var type 

func setPlaceable(placeableName):
	print(spriteNode)
	print(placeableName)
	var data = CraftableItems.placeables[placeableName]
	
	type = placeableName
	
	print(CraftableItems.items[placeableName]["png"])
	spriteNode.texture = load(CraftableItems.items[placeableName]["png"])
	spriteNode.scale = Vector2(data["scale"], data["scale"])
	rangeCollision.shape.radius = data["range"]
	rangeCollision.disabled = false
	
	await get_tree().create_timer(data["lifetime"]).timeout
	
	queue_free()
