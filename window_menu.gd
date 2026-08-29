extends MenuButton

@onready var label: Label = $"../Windowed"  # adjust path to your Label

func _ready() -> void:
	var popup = get_popup()
	popup.add_item("Windowed", 0)
	popup.add_item("Fullscreen", 1)
	popup.add_item("Borderless Windowed", 2)
	
	popup.id_pressed.connect(_on_id_pressed)
	
	_update_label_for_current_mode()

func _on_id_pressed(id: int) -> void:
	match id:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
			label.text = "Windowed"
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
			label.text = "Fullscreen"
		2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
			label.text = "Borderless Windowed"

func _update_label_for_current_mode() -> void:
	match DisplayServer.window_get_mode():
		DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN, DisplayServer.WINDOW_MODE_FULLSCREEN:
			label.text = "Fullscreen"
		_:
			label.text = "Windowed"
