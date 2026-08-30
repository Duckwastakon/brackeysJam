extends Button

@onready var settingsPanel: Control = get_node("../settingsPanel")

func _on_pressed() -> void:
	settingsPanel.visible = !settingsPanel.visible
	get_tree().paused = settingsPanel.visible
