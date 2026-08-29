extends VBoxContainer

func _ready() -> void:
	for recipe_name in CraftableItems.cratables.keys():
		add_recipe_row(recipe_name)

func add_recipe_row(recipe_name: String) -> void:
	var recipe = CraftableItems.cratables[recipe_name]
	var item_data = CraftableItems.items[recipe_name]
	
	var entry = VBoxContainer.new()
	entry.add_theme_constant_override("separation", 4)
	
	var row = HBoxContainer.new()
	row.add_theme_constant_override("separation", 12)
	
	var icon = TextureRect.new()
	icon.texture = load(item_data["png"])
	icon.custom_minimum_size = Vector2(300, 300)
	icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	row.add_child(icon)
	
	var name_label = Label.new()
	name_label.text = recipe_name.capitalize()
	name_label.custom_minimum_size = Vector2(150, 0)
	name_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	row.add_child(name_label)
	
	var mats_box = HFlowContainer.new()
	mats_box.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	for mat_name in recipe["items"].keys():
		var mat_amount = recipe["items"][mat_name]
		
		var pair = HBoxContainer.new()
		
		var mat_icon = TextureRect.new()
		mat_icon.texture = load(CraftableItems.items[mat_name]["png"])
		mat_icon.custom_minimum_size = Vector2(225, 225)
		mat_icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		mat_icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		pair.add_child(mat_icon)
		
		var amount_label = Label.new()
		amount_label.text = "x%d" % mat_amount
		pair.add_child(amount_label)
		
		mats_box.add_child(pair)
	row.add_child(mats_box)
	
	var time_label = Label.new()
	time_label.text = "%.1fs" % recipe["time"]
	row.add_child(time_label)
	
	entry.add_child(row)
	
	var desc = item_data.get("desc", "")
	if desc != "":
		var desc_label = Label.new()
		desc_label.text = desc
		desc_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		desc_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		desc_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		desc_label.modulate = Color(0.7, 0.7, 0.7)
		entry.add_child(desc_label)
	
	add_child(entry)
	
	var separator = HSeparator.new()
	separator.add_theme_constant_override("separation", 8)
	add_child(separator)
	
	var spacer = Control.new()
	spacer.custom_minimum_size = Vector2(0, 8)
	add_child(spacer)
