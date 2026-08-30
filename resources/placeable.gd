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
	
	var newRange: Panel = preload("res://resources/warmth_zone.tscn").instantiate()
	
	if(data.has("warmth")):
		newRange.size = Vector2(data["range"] * 2, data["range"] * 2)
		get_parent().get_parent().add_child(newRange)
		newRange.get_child(0).scale = Vector2(data["range"] * 2 / 320, data["range"] * 2 / 320)
		newRange.get_child(0).position = Vector2(data["range"] ,data["range"])
		newRange.z_index = 2
		
		newRange.global_position = global_position + Vector2(-data["range"], -data["range"])
	
	await get_tree().create_timer(data["lifetime"]).timeout
	
	queue_free()
	newRange.queue_free()
