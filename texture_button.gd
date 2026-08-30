extends Button

@onready var recipe_panel: Control = get_node("../RecipePanel")

func _on_pressed() -> void:
	recipe_panel.visible = !recipe_panel.visible
	get_tree().paused = recipe_panel.visible
