extends TextureButton

@onready var recipe_panel: Control = get_node("../RecipePanel")

func _ready() -> void:
	var img = texture_normal.get_image()
	var bitmap = BitMap.new()
	bitmap.create_from_image_alpha(img)
	texture_click_mask = bitmap


func _on_pressed() -> void:
	recipe_panel.visible = !recipe_panel.visible
