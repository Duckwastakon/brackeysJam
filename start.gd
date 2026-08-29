extends Node2D
@onready var camera = $Camera2D
@onready var rabbit = $Panel/Rabbit
@export var swoosh_duration := 1.5
@export var spin_speed := 5
var startCameraPositionX = 572
var endCameraPositionX = 2572
var midX = 1548.0
var wait = 1.2


var YPosition = 326.00

func _ready() -> void:
	camera.position = Vector2(startCameraPositionX, YPosition)

func go_to(target_position: Vector2):
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(camera, "position", target_position, swoosh_duration)

func _process(delta: float) -> void:
	rabbit.rotation += spin_speed * delta


func _on_settings_pressed() -> void:
	go_to(Vector2(midX, YPosition))
	await get_tree().create_timer(wait).timeout
	go_to(Vector2(endCameraPositionX, YPosition))

func _on_settings_2_pressed() -> void:
	go_to(Vector2(midX, YPosition))
	await get_tree().create_timer(wait).timeout
	go_to(Vector2(startCameraPositionX, YPosition))


func _on_exit_pressed() -> void:
	var tween = create_tween()
	tween.tween_property(Transition.fade, "color:a", 1.0, 0.4)
	await tween.finished
	get_tree().quit()

func _on_start_pressed() -> void:
	Transition.change_scene("res://map/map.tscn")
