extends Node2D
@onready var one = $Marker2D
@onready var two = $Marker2D2
@onready var timer = $Timer
@onready var drawing = $Node2D
@onready var tim = $Timer2

var all
var p = Vector2(0, 0)
var down = 964

func _ready() -> void:
	tim.start()
	drawing.visible = true
	drawing.position.y = -809.0
	var tween = create_tween()
	tween.tween_property(drawing, "position:y", -4.0, 5)
	all = shuffle()
	getPosition()



func shuffle() -> Array:
	var unique_names := {}
	
	for key in CraftableItems.items.keys():
		unique_names[key] = true
	for key in CraftableItems.placeables.keys():
		unique_names[key] = true
	for key in CraftableItems.resourceNodes.keys():
		unique_names[key] = true
	
	var result: Array = unique_names.keys()
	result.shuffle()
	return result

func get_item_data(item_name: String) -> Dictionary:
	if CraftableItems.items.has(item_name):
		return CraftableItems.items[item_name]
	elif CraftableItems.placeables.has(item_name):
		return CraftableItems.placeables[item_name]
	elif CraftableItems.resourceNodes.has(item_name):
		return CraftableItems.resourceNodes[item_name]
	return {}

func getPosition():
	if randf() < 0.5:
		p = one.position
	else:
		p = two.position


func _on_timer_timeout() -> void:
	$ColorRect2/Button.disabled = false
	var index = randi() % all.size()
	var random_item = all[index]
	var item_data = get_item_data(random_item)
	
	if not item_data.has("png"):
		return  
	
	var icon_texture = load(item_data["png"])
	
	var sprite = Sprite2D.new()
	sprite.texture = icon_texture
	sprite.scale = Vector2(0.2, 0.2)
	add_child(sprite)
	sprite.position = p
	
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(sprite, "position:y", down, 10)
	tween.tween_property(sprite, "rotation", sprite.rotation + TAU * 2, 8)
	
	getPosition()
	timer.start(randi_range(3, 6))
	await tween.finished
	sprite.queue_free()


func _on_button_pressed() -> void:
	var tween = create_tween()
	tween.tween_property(Transition.fade, "color:a", 1.0, 0.4)
	await tween.finished
	get_tree().quit()


func _on_timer_2_timeout() -> void:
	var tween = create_tween()
	tween.tween_property(drawing, "position:y", 744.0, 5)
