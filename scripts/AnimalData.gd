extends Node

var profiles = {
	"rabbit": {
		"speed": 25, "hp": 5, "food_min": 1, "food_max": 2,
		"move_range": 20, "max_stop": 2, "random_wait": false,
		"sprite": preload("res://drawn assets/rabbit.png"),
		"scale": Vector2(0.05, 0.05)
	},
	"fox": {
		"speed": 45, "hp": 10, "food_min": 1, "food_max": 3,
		"move_range": 30, "max_stop": 2, "random_wait": false,
		"sprite": preload("res://drawn assets/fox.png"),
		"scale": Vector2(0.1, 0.1)
	},
	"deer": {
		"speed": 50, "hp": 15, "food_min": 2, "food_max": 5,
		"move_range": 50, "max_stop": 1, "random_wait": true,
		"sprite": preload("res://drawn assets/deer.png"),
		"scale": Vector2(0.1, 0.1)
	},
	"bear": {
		"speed": 60, "hp": 50, "food_min": 6, "food_max": 12,
		"move_range": 50, "max_stop": 4, "random_wait": false,
		"sprite": preload("res://drawn assets/bear.png"),
		"scale": Vector2(0.15, 0.15)
	},
}

var phase = 1
var change = 10
var norm = 50
var mon_speed

func _ready() -> void:
	set_monster_speed()

func set_monster_speed():
	var current = norm + change * phase
	if Global.dayTime:
		mon_speed = current
	else:
		mon_speed = current * 2
