extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setCameraOffset()

func setCameraOffset():
	var currentCam: Camera2D = get_viewport().get_camera_2d()
	currentCam.offset = Vector2(64, 0)
