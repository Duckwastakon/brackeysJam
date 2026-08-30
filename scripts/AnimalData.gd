extends Node

var profiles = {
	"rabbit": {
		"speed": 300, "hp": 5, "food_min": 1, "food_max": 1,
		"move_range": 20, "max_stop": 2, "random_wait": false,
		"sprite": preload("res://drawn assets/animals/rabbit.png"),
		"scale": Vector2(0.6, 0.6)
	},
	"fox": {
		"speed": 325, "hp": 25, "food_min": 1, "food_max": 3,
		"move_range": 30, "max_stop": 2, "random_wait": false,
		"sprite": preload("res://drawn assets/animals/fox.PNG"),
		"scale": Vector2(1, 1)
	},
	"deer": {
		"speed": 350, "hp": 30, "food_min": 2, "food_max": 5,
		"move_range": 50, "max_stop": 1, "random_wait": true,
		"sprite": preload("res://drawn assets/animals/deer.PNG"),
		"scale": Vector2(1, 1)
	},
	"bear": {
		"speed": 230, "hp": 75, "food_min": 8, "food_max": 12,
		"move_range": 50, "max_stop": 4, "random_wait": false,
		"sprite": preload("res://drawn assets/animals/bear.PNG"),
		"scale": Vector2(1, 1)
	},
}

var norm = 375
var mon_speed

func _ready() -> void:
	set_monster_speed()

func set_monster_speed():
	var current = norm
	if Global.dayTime:
		mon_speed = current
	else:
		mon_speed = current * 1.25
