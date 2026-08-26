extends Node2D

func _process(delta: float) -> void:
	look_at(get_global_mouse_position())

func placeBuild(buildName):
	var data = CraftableItems.items[buildName]
	if data["type"] == "placeable":
		var newPlaceable = Sprite2D.new()
		newPlaceable.texture = load(data["png"])
		newPlaceable.global_position = get_child(0).global_position
		get_parent().get_parent().add_child(newPlaceable)
