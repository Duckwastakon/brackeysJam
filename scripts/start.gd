extends Node2D



func _on_settings_button_up() -> void:
	if $extraScreens/settings.visible == true:
		$extraScreens/settings.visible = false
	else:
		$extraScreens/settings.visible = true

func _on_tutorial_button_up() -> void:
	if $extraScreens/tutorial.visible == true:
		$extraScreens/tutorial.visible = false
	else:
		$extraScreens/tutorial.visible = true

func _on_start_button_up() -> void:
	Transition.change_scene("res://map/map.tscn")
