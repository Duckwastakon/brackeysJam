extends Area2D

signal damage

func _ready() -> void:
	connect("damage", get_parent().takeDamage)
