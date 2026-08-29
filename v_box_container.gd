extends VBoxContainer

func _ready() -> void:
	for recipe_name in CraftableItems.cratables.keys():
		add_recipe_row(recipe_name)

func add_recipe_row(recipe_name: String) -> void:
	var recipe = CraftableItems.cratables[recipe_name]
	var item_data = CraftableItems.items[recipe_name]
	
	var row = HBoxContainer.new()
	row.add_theme_constant_override("separation", 12)
	
	# Item icon
	var icon = TextureRect.new()
	icon.texture = load(item_data["png"])
	icon.custom_minimum_size = Vector2(200, 200)
	icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	row.add_child(icon)
	
	# Item name
	var name_label = Label.new()
	name_label.text = recipe_name.capitalize()
	name_label.custom_minimum_size = Vector2(150, 0)
	row.add_child(name_label)
	
	# Required materials
	var mats_box = HBoxContainer.new()
	for mat_name in recipe["items"].keys():
		var mat_amount = recipe["items"][mat_name]
		var mat_icon = TextureRect.new()
		mat_icon.texture = load(CraftableItems.items[mat_name]["png"])
		mat_icon.custom_minimum_size = Vector2(180, 180)
		mat_icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		mat_icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		mats_box.add_child(mat_icon)
		
		var amount_label = Label.new()
		amount_label.text = "x%d" % mat_amount
		mats_box.add_child(amount_label)
	row.add_child(mats_box)
	
	# Optional: craft time
	var time_label = Label.new()
	time_label.text = "%.1fs" % recipe["time"]
	row.add_child(time_label)
	
	add_child(row)


func _on_texture_button_pressed() -> void:
	pass # Replace with function body.
