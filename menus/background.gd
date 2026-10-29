extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate_resources()

var resource_scene = load("res://resources/resource.tscn")

func generate_resources() -> void:
	for pos in 35:
		if randf() < 0.5:
			var new_rec = resource_scene.instantiate()
			
			$Node2D.add_child(new_rec)
			new_rec.position = Vector2(randi_range(-100, 1200), randi_range(-50, 600))
